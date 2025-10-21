<script>
  import { onMount } from "svelte";
  import Chart from "chart.js/auto";

  let links = [
    { id: 1, short: "g-o-o-g", original: "https://google.com", clicks: 120, stats: [20, 18, 25, 15, 10, 18, 14] },
    { id: 2, short: "sv-docs", original: "https://svelte.dev", clicks: 45, stats: [5, 6, 8, 7, 4, 5, 10] },
  ];

  let currentView = "default";
  let originalUrl = "";

  let username = "UserName - display";
  let profilePic;
  let fileInput;

  function generateShortCode(length = 6) {
    const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    let result = "";
    for (let i = 0; i < length; i++) result += chars.charAt(Math.floor(Math.random() * chars.length));
    return result;
  }

  async function handleCreateLink() {
    if (!originalUrl) { alert("Please enter an original link."); return; }
    const newLink = { id: Date.now(), short: generateShortCode(), original: originalUrl, clicks: 0, stats: [0,0,0,0,0,0,0] };
    links = [...links, newLink];
    currentView = newLink.id;
    originalUrl = "";
    const response = await fetch("/api/login", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                email: email,
                password: password,
            }),
        });
        if (response.status === 200) {
            console.log(await response.json());
        }
  }

  function selectLink(linkId) { currentView = linkId; setTimeout(drawChart,0); }
  function showNewLinkForm() { currentView = "new"; }

  function handleProfilePicUpload(event) {
    const file = event.target.files[0];
    if (file) { const reader = new FileReader(); reader.onload = e => profilePic = e.target.result; reader.readAsDataURL(file); }
  }

  function deleteLink(linkId) { links = links.filter(l => l.id !== linkId); currentView="default"; }

  function hoverDelete(e) { e.target.style.backgroundColor="#c92a3a"; }
  function leaveDelete(e) { e.target.style.backgroundColor="#e63946"; }

  $: selectedLink = links.find(link => link.id === currentView);
  $: last7Average = selectedLink ? (selectedLink.stats.reduce((a,b)=>a+b,0)/selectedLink.stats.length).toFixed(1) : 0;

  let chart;
  function drawChart() {
    if(!selectedLink) return;
    const ctx = document.getElementById("linkChart");
    if(!ctx) return;
    if(chart) chart.destroy();

    function getLast7Dates(){
      const dates=[]; const today = new Date();
      for(let i=6;i>=0;i--){ const d=new Date(); d.setDate(today.getDate()-i); dates.push(d.toLocaleDateString("en-GB",{day:"2-digit",month:"short"})); }
      return dates;
    }

    chart = new Chart(ctx,{
      type:"line",
      data:{
        labels:getLast7Dates(),
        datasets:[
          { label:"Clicks (Last 7 Days)", data:selectedLink.stats, borderWidth:2, borderColor:"#10a37f", backgroundColor:"rgba(16,163,127,0.2)", tension:0.3 },
          { label:"7-Day Average", data:Array(7).fill(last7Average), borderWidth:2, borderColor:"#f4a261", borderDash:[5,5], pointRadius:0, fill:false, tension:0 }
        ]
      },
      options:{ responsive:true, plugins:{ legend:{ display:true } }, scales:{ y:{ beginAtZero:true } } }
    });
  }

  onMount(()=>{ if(selectedLink) drawChart(); });
</script>

<main class="dashboard">
  <nav class="sidebar">
    <div class="profile-section">
      {#if profilePic}
        <img src={profilePic} alt="Profile Picture" class="profile-circle-img" on:click={() => fileInput.click()}/>
      {:else}
        <div class="profile-circle" on:click={() => fileInput.click()}>+</div>
      {/if}
      <div class="username">{username}</div>
      <input type="file" accept="image/*" bind:this={fileInput} on:change={handleProfilePicUpload} style="display:none"/>
    </div>

    <button class="new-link-btn" on:click={showNewLinkForm}><span class="plus-icon">+</span>New Link</button>

    <ul class="link-list">
      {#each links as link (link.id)}
        <li style="display:flex;align-items:center;justify-content:space-between;gap:0.5rem;">
          <button class="link-item" on:click={() => selectLink(link.id)} class:active={currentView===link.id} style="flex:1; display:flex; justify-content:space-between;align-items:center;">
            <span>{link.short}</span>
          </button>
          <div class="menu-container" style="position:relative;">
            <button class="menu-btn" on:click={() => (link.showMenu=!link.showMenu)}>⋮</button>
            {#if link.showMenu}
              <div class="menu-dropdown" style="position:absolute;right:0;top:100%;background:white;border:1px solid #ccc;border-radius:6px;box-shadow:0 2px 6px rgba(0,0,0,0.15);min-width:120px;z-index:10;">
                <button on:click={() => { navigator.clipboard.writeText(link.original); link.showMenu=false; }} style="width:100%;padding:0.5rem 1rem;text-align:left;border:none;background:none;cursor:pointer;">Copy Link</button>
                <button on:click={() => deleteLink(link.id)} style="width:100%;padding:0.5rem 1rem;text-align:left;border:none;background:none;color:#e63946;cursor:pointer;">Delete</button>
              </div>
            {/if}
          </div>
        </li>
      {/each}
    </ul>
  </nav>

  <section class="main-content">
    {#if currentView==="default"}
      <div class="content-center"><h1>Link Shortener</h1><p>Click "+ New Link" in the sidebar to get started.</p></div>
    {:else if currentView==="new"}
      <div class="content-center">
        <h2>Create a new shortened link</h2>
        <form class="link-form" on:submit|preventDefault={handleCreateLink}>
          <div class="form-group">
            <label for="original-link">Original Link</label>
            <input id="original-link" type="url" placeholder="https://your-very-long-link.com/..." bind:value={originalUrl}/>
          </div>
          <button type="submit" class="submit-btn">Shorten</button>
        </form>
      </div>
    {:else if selectedLink}
      <div class="content-center">
        <h2>Link Details</h2>
        <div class="link-details">
          <p><strong>Short Link:</strong><span>{selectedLink.short}</span></p>
          <p><strong>Original Link:</strong><a href={selectedLink.original} target="_blank" rel="noopener">{selectedLink.original}</a></p>

          <div style="display:flex;align-items:center;justify-content:space-between;gap:2rem;margin-top:2rem;flex-wrap:wrap;">
            <div style="background-color:#10a37f;color:white;border-radius:8px;padding:1rem 2rem;text-align:center;min-width:140px;">
              <h3 style="margin:0;font-size:1rem;">Total Clicks</h3>
              <p style="margin:0;font-size:1.8rem;font-weight:bold;">{selectedLink.clicks}</p>
            </div>

            <div style="background-color:#f4a261;color:white;border-radius:8px;padding:1rem 2rem;text-align:center;min-width:140px;">
              <h3 style="margin:0;font-size:1rem;">Avg Clicks (7 Days)</h3>
              <p style="margin:0;font-size:1.8rem;font-weight:bold;">{last7Average}</p>
            </div>

            <div style="flex:1;min-width:300px;">
              <canvas id="linkChart" height="120"></canvas>
            </div>
          </div>

          <div style="margin-top:1.5rem;text-align:right;">
            <button on:click={() => deleteLink(selectedLink.id)} on:mouseover={hoverDelete} on:mouseout={leaveDelete} style="background-color:#e63946;color:white;border:none;padding:0.6rem 1rem;border-radius:6px;cursor:pointer;transition:background-color 0.2s;">Delete Link</button>
          </div>
        </div>
      </div>
    {/if}
  </section>
</main>

<style>
  :global(body){margin:0;font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Oxygen,Ubuntu,Cantarell,"Open Sans","Helvetica Neue",sans-serif;color:#333;}
  .dashboard{display:flex;height:100vh;width:100vw;background-color:#f9f9f9;}
  .sidebar{width:260px;flex-shrink:0;background-color:#202123;color:white;padding:1rem;display:flex;flex-direction:column;gap:1.5rem;}
  .profile-section{display:flex;align-items:center;gap:0.75rem;padding:0.75rem 1rem;background-color:#2a2b2e;border-radius:8px;cursor:pointer;}
  .profile-circle{width:60px;height:60px;border-radius:50%;background-color:#10a37f;color:white;font-size:1.5rem;font-weight:700;display:flex;align-items:center;justify-content:center;flex-shrink:0;transition:background-color 0.2s;}
  .profile-circle:hover{background-color:#0e8e6f;}
  .profile-circle-img{width:45px;height:45px;border-radius:50%;object-fit:cover;flex-shrink:0;}
  .username{font-size:0.95rem;font-weight:500;color:#fff;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;}
  .new-link-btn{display:flex;align-items:center;gap:0.75rem;width:90%;padding:0.75rem 1rem;font-size:0.9rem;font-weight:500;background-color:transparent;color:white;border:1px solid #4d4d4d;border-radius:8px;cursor:pointer;transition:background-color 0.2s;}
  .new-link-btn:hover{background-color:#2a2b2e;}
  .plus-icon{font-size:1.25rem;font-weight:300;}
  .menu-btn{background-color:black;color:white;border:none;border-radius:50%;width:28px;height:28px;display:flex;align-items:center;justify-content:center;cursor:pointer;font-size:1rem;}
  .menu-btn:hover{background-color:#333;}
  .link-list{list-style:none;padding:0;margin:0;overflow-y:auto;flex-grow:1;}
  .link-item{width:90%;text-align:left;background:none;border:none;color:#ececec;padding:0.75rem 1rem;border-radius:8px;cursor:pointer;font-size:0.9rem;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;transition:background-color 0.2s;}
  .link-item:hover{background-color:#2a2b2e;}
  .link-item.active{background-color:#343541;}
  .main-content{flex-grow:1;padding:2rem;overflow-y:auto;}
  .content-center{max-width:800px;margin:0 auto;text-align:center;}
  h1,h2{color:#111;}
  .link-form{display:flex;flex-direction:column;gap:1.5rem;margin-top:2rem;text-align:left;}
  .form-group{display:flex;flex-direction:column;gap:0.5rem;}
  .form-group label{font-weight:600;font-size:0.9rem;}
  .form-group input{font-size:1rem;padding:0.75rem 1rem;border:1px solid #ddd;border-radius:8px;}
  .submit-btn{font-size:1rem;font-weight:600;padding:0.75rem;border:none;border-radius:8px;background-color:#10a37f;color:white;cursor:pointer;transition:background-color 0.2s;}
  .submit-btn:hover{background-color:#0e8e6f;}
  .link-details{margin-top:2rem;padding:1.5rem;background-color:white;border:1px solid #eee;border-radius:8px;text-align:left;}
  .link-details p{font-size:1.1rem;display:flex;flex-direction:column;gap:0.25rem;}
  .link-details p strong{font-weight:600;color:#555;}
  .link-details p span{font-family:"Courier New",Courier,monospace;background-color:#f4f4f4;padding:0.25rem 0.5rem;border-radius:4px;}
  .link-details p a{color:#10a37f;text-decoration:none;word-break:break-all;}
  .link-details p a:hover{text-decoration:underline;}
</style>

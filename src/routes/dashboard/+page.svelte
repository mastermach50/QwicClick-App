<script>
  // --- STATE ---

  // A reactive list of our shortened links.
  let links = [
    { id: 1, short: "g-o-o-g", original: "https://google.com" },
    { id: 2, short: "sv-docs", original: "https://svelte.dev" },
  ];

  // Controls what's shown in the main content area
  // 'default', 'new', or a link ID
  let currentView = "default";

  // Variable to hold the single form input value
  let originalUrl = "";

  // --- LOGIC ---

  /**
   * Generates a simple random short code.
   * In a real app, you'd want to ensure this is unique.
   */
  function generateShortCode(length = 6) {
    const chars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    let result = "";
    for (let i = 0; i < length; i++) {
      result += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return result;
  }

  /**
   * Handles the submission of the new link form.
   */
  function handleCreateLink() {
    // Basic validation
    if (!originalUrl) {
      alert("Please enter an original link.");
      return;
    }

    // --- NEW LOGIC ---
    // Generate the short code automatically
    const newShortCode = generateShortCode();

    // Create the new link object
    const newLink = {
      id: Date.now(), // Use a simple timestamp as a unique ID
      short: newShortCode,
      original: originalUrl,
    };

    // Add the new link to our reactive 'links' array
    links = [...links, newLink];

    // As requested: display the new link in the center after creation
    currentView = newLink.id;

    // Clear the form field
    originalUrl = "";
  }

  /**
   * Selects a link from the sidebar to view its details.
   */
  function selectLink(linkId) {
    currentView = linkId;
  }

  /**
   * Shows the "create new link" form.
   */
  function showNewLinkForm() {
    currentView = "new";
  }

  // A computed property to find the currently selected link (if any)
  $: selectedLink = links.find((link) => link.id === currentView);
</script>

<main class="dashboard">
  <nav class="sidebar">
    <button class="new-link-btn" on:click={showNewLinkForm}>
      <span class="plus-icon">+</span>
      New Link
    </button>

    <ul class="link-list">
      {#each links as link (link.id)}
        <li>
          <button
            class="link-item"
            on:click={() => selectLink(link.id)}
            class:active={currentView === link.id}
          >
            {link.short}
            <span class="link-list-span-point">></span>
          </button>
        </li>
      {/each}
    </ul>
  </nav>

  <section class="main-content">
    {#if currentView === 'default'}
      <div class="content-center">
        <h1>Link Shortener</h1>
        <p>Click "+ New Link" in the sidebar to get started.</p>
      </div>
    {:else if currentView === 'new'}
      <div class="content-center">
        <h2>Create a new shortened link</h2>
        <form class="link-form" on:submit|preventDefault={handleCreateLink}>
          <div class="form-group">
            <label for="original-link">Original Link</label>
            <input
              id="original-link"
              type="url"
              placeholder="https://your-very-long-link.com/..."
              bind:value={originalUrl}
            />
          </div>
          <button type="submit" class="submit-btn">Shorten</button>
        </form>
      </div>
    {:else if selectedLink}
      <div class="content-center">
        <h2>Link Details</h2>
        <div class="link-details">
          <p>
            <strong>Short Link:</strong>
            <span>{selectedLink.short}</span>
          </p>
          <p>
            <strong>Original Link:</strong>
            <a href={selectedLink.original} target="_blank" rel="noopener">
              {selectedLink.original}
            </a>
          </p>
        </div>
      </div>
    {/if}
  </section>
</main>

<style>
  /* --- Global & Layout --- */
  :global(body) {
    margin: 0;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    color: #333;
  }

  .dashboard {
    display: flex;
    height: 100vh;
    width: 100vw;
    background-color: #f9f9f9;
  }

  /* --- 1. Sidebar --- */
  .sidebar {
    width: 260px;
    flex-shrink: 0;
    background-color: #202123;
    color: white;
    padding: 1rem;
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
  }

  .new-link-btn {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    width: 90%;
    padding: 0.75rem 1rem;
    font-size: 0.9rem;
    font-weight: 500;
    background-color: transparent;
    color: white;
    border: 1px solid #4d4d4d;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.2s;
  }

  .new-link-btn:hover {
    background-color: #2a2b2e;
  }

  .plus-icon {
    font-size: 1.25rem;
    font-weight: 300;
  }

  .link-list {
    list-style: none;
    padding: 0;
    margin: 0;
    overflow-y: auto;
    flex-grow: 1;
  }
  .link-list-span-point{
    text-align: right;
  }

  .link-item {
    width: 90%;
    text-align: left;
    background: none;
    border: none;
    color: #ececec;
    padding: 0.75rem 1rem;
    border-radius: 8px;
    cursor: pointer;
    font-size: 0.9rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    transition: background-color 0.2s;
  }

  .link-item:hover {
    background-color: #2a2b2e;
  }

  .link-item.active {
    background-color: #343541;
  }

  /* --- 2. Main Content --- */
  .main-content {
    flex-grow: 1;
    padding: 2rem;
    overflow-y: auto;
  }

  .content-center {
    max-width: 800px;
    margin: 0 auto;
    text-align: center;
  }

  h1,
  h2 {
    color: #111;
  }

  /* --- Form Styles --- */
  .link-form {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
    margin-top: 2rem;
    text-align: left;
  }

  .form-group {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }

  .form-group label {
    font-weight: 600;
    font-size: 0.9rem;
  }

  .form-group input {
    font-size: 1rem;
    padding: 0.75rem 1rem;
    border: 1px solid #ddd;
    border-radius: 8px;
  }

  .submit-btn {
    font-size: 1rem;
    font-weight: 600;
    padding: 0.75rem;
    border: none;
    border-radius: 8px;
    background-color: #10a37f;
    color: white;
    cursor: pointer;
    transition: background-color 0.2s;
  }

  .submit-btn:hover {
    background-color: #0e8e6f;
  }

  /* --- Link Details Styles --- */
  .link-details {
    margin-top: 2rem;
    padding: 1.5rem;
    background-color: white;
    border: 1px solid #eee;
    border-radius: 8px;
    text-align: left;
  }

  .link-details p {
    font-size: 1.1rem;
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
  }

  .link-details p strong {
    font-weight: 600;
    color: #555;
  }

  .link-details p span {
    font-family: "Courier New", Courier, monospace;
    background-color: #f4f4f4;
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
  }

  .link-details p a {
    color: #10a37f;
    text-decoration: none;
    word-break: break-all;
  }

  .link-details p a:hover {
    text-decoration: underline;
  }
</style>
```
<script>
    import "$lib/daisy.css";
    import { onMount } from "svelte";
    // import jdenticon from "jdenticon/standalone";
    import { Chart, registerables } from "chart.js";
    import Success from "$lib/components/alerts/success.svelte";
    import Error from "$lib/components/alerts/error.svelte";
    import Panel from "$lib/components/panel.svelte";

    Chart.register(...registerables);

    let sessiontoken = null;
    let username = $state(null);
    let email = $state(null);
    let links = $state([]);
    let currentlink = $state(null);
    let currentlinkCount = $state(0);

    let successMessage = $state(null);
    let successRef;

    let errorMessage = $state(null);
    let errorRef;

    let panelRef = $state(null);

    let chart;
    let chartRef = $state(null);

    let refetchRepeat;

    $effect(() => {
        currentlinkCount = "~";
        currentlink = currentlink;
    });

    $effect(async () => {
        if (!currentlink) return;

        let response = await fetch("https://qwic.click/api/get_link_stats", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                sessiontoken: sessiontoken,
            },
            body: JSON.stringify({
                linkid: currentlink.linkid,
            }),
        });

        if (response.status === 200) {
            let data = await response.json();
            currentlinkCount = data.count;
        }

        // Generate labels for the last 7 days
        const days = [...Array(7)].map((_, i) => {
            const d = new Date();
            d.setDate(d.getDate() - (6 - i)); // oldest to newest
            return d.toLocaleDateString("en-US", { weekday: "short" });
        });

        // Example data values
        let values = [0, 0, 0, 0, 0, 0, currentlinkCount];

        if (chart) {
            chart.destroy();
        }

        // Create the chart
        chart = new Chart(chartRef, {
            type: "line",
            data: {
                labels: days,
                datasets: [
                    {
                        label: "Value (last 7 days)",
                        data: values,
                        borderColor: "rgb(75, 192, 192)",
                        backgroundColor: "rgba(75, 192, 192, 0.2)",
                        fill: true,
                        tension: 0.3,
                    },
                ],
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                    },
                },
            },
        });
    });

    onMount(async () => {
        // Get session token from cookie
        sessiontoken = document.cookie.split("sessiontoken=")[1];
        console.log(sessiontoken);

        // Fetch user details
        let response = await fetch("https://qwic.click/api/whoami", {
            method: "GET",
            headers: {
                "Content-Type": "none",
                sessiontoken: sessiontoken,
            },
        });

        if (response.status === 200) {
            let data = await response.json();
            username = data.username;
            email = data.email;
            console.log(username, email);
        } else {
            window.location.href = "/login";
        }

        // Fetch all links for user
        getAllLinks();

        // Update avatar
        jdenticon.update("#avatar", username);
    });

    // let update_link_stats = async () => {

    // }

    let getAllLinks = async () => {
        let response = await fetch("https://qwic.click/api/get_all_links", {
            method: "GET",
            headers: {
                "Content-Type": "none",
                sessiontoken: sessiontoken,
            },
        });

        if (response.status === 200) {
            let data = await response.json();
            links = data.links;
            console.log(links);
        } else {
            window.location.href = "/login";
        }
    };

    let addLink = async (link) => {
        let response = await fetch("https://qwic.click/api/add_link", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                sessiontoken: sessiontoken,
            },
            body: JSON.stringify({
                longlink: link,
            }),
        });

        if (response.status === 200) {
            let data = await response.json();
            links.push(data);
            currentlink = links.at(-1);
            panelRef.hide();
            console.log("Link added successfully");
            successMessage = "Link added successfully";
            successRef.show();
        } else {
            console.log("Error adding link");
            errorMessage = "Error adding link";
            errorRef.show();
        }
    };

    let updateLink = async () => {
        let response = await fetch("https://qwic.click/api/update_link", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                sessiontoken: sessiontoken,
            },
            body: JSON.stringify({
                shortlink: currentlink.shortlink,
                longlink: currentlink.longlink,
                linkid: currentlink.linkid,
            }),
        });

        if (response.status === 200) {
            console.log("Link updated successfully");
            successMessage = "Link updated successfully";
            successRef.show();
        } else {
            console.log("Error updating link");
            errorMessage = "Error updating link";
            errorRef.show();
        }
    };

    let deleteLink = async () => {
        let response = await fetch("https://qwic.click/api/delete_link", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                sessiontoken: sessiontoken,
            },
            body: JSON.stringify({
                linkid: currentlink.linkid,
            }),
        });

        if (response.status === 200) {
            links = links.filter((link) => link.linkid !== currentlink.linkid);
            currentlink = null;
            console.log("Link deleted successfully");
            successMessage = "Link deleted successfully";
            successRef.show();
        } else {
            console.log("Error deleting link");
            errorMessage = "Error deleting link";
            errorRef.show();
        }
    };

    let logout = async () => {
        document.cookie = "sessiontoken=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
        window.location.href = "/login";
    };
</script>

<Success message={successMessage} bind:this={successRef} />
<Error message={errorMessage} bind:this={errorRef} />
<Panel {addLink} bind:this={panelRef} />
<main>
    <nav class="sidebar">
        <div class="userbox">
            <svg id="avatar"></svg>
            <div class="userdetails">
                {username}
                <button class="btn btn-error btn-xs" onclick={logout}>Logout</button>
            </div>
        </div>
        <button class="btn btn-block btn-dash" onclick={panelRef.show}>+ New Link</button>
        {#each links as link}
            <button
                class="shortlink btn btn-block btn-secondary"
                onclick={() => (currentlink = link)}>{link.shortlink}</button
            >
        {/each}
    </nav>
    <div class="content">
        {#if currentlink === null}
            <h1 class="no-link-selected">Select a link or add a new link</h1>
        {:else}
            <div class="linkbox">
                <label for="shortlink-input">Shortcode:<br /></label>
                <input
                    id="shortlink-input"
                    type="text"
                    placeholder="Shortcode"
                    bind:value={currentlink.shortlink}
                    class="input"
                /><br />
                <label for="destination-input">Destination:<br /></label>
                <input
                    id="destination-input"
                    type="text"
                    placeholder="Destination"
                    bind:value={currentlink.longlink}
                    class="input"
                /><br />
                <button class="btn btn-primary" onclick={updateLink}>Update</button>
                <button class="btn btn-error" onclick={deleteLink}>Delete</button>
            </div>
            <div class="statbox">
                <div class="stats shadow">
                    <div class="stat">
                        <div class="stat-title text-primary">Total Clicks</div>
                        <div class="stat-value">{currentlinkCount}</div>
                        <div class="stat-desc">100% more than last week</div>
                    </div>
                </div>
                <canvas id="count-chart" bind:this={chartRef}></canvas>
            </div>
        {/if}
    </div>
</main>

<style>
    main {
        display: flex;
        height: 100vh;
    }

    .sidebar {
        width: 18rem;
        background-color: var(--color-base-300);
        color: var(--color-base-content);
        padding: 1rem;
    }

    .content {
        flex-grow: 1;
        padding: 1rem;
    }

    .userbox {
        display: flex;
        align-items: center;
        justify-content: left;
        gap: 1rem;
        padding: 1rem;

        font-weight: 800;
        font-size: 1.5rem;

        svg {
            background-color: white;
            border-radius: 100%;
        }
    }

    .shortlink {
        margin-top: 1rem;
    }

    .no-link-selected {
        text-align: center;
        font-size: 1.5rem;
        font-weight: 600;
        padding: 4rem;
    }

    .linkbox {
        padding: 1rem;
        background-color: var(--color-base-200);
        border-radius: 1rem;

        label {
            font-weight: 800;
        }

        input {
            width: 100%;
        }

        button {
            margin-top: 1rem;
        }
    }

    .statbox {
        padding: 1rem;
        margin-top: 1rem;
        background-color: var(--color-base-200);
        border-radius: 1rem;

        .stat {
            background-color: var(--color-base-100);
        }
    }
</style>

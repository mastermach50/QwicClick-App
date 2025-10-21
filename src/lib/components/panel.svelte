<script>
    import "$lib/daisy.css";

    let { addLink } = $props();

    let visible = $state(false);

    let link = $state(null);

    export function show() {
        visible = true;
    }

    export function hide() {
        visible = false;
        link = null;
    }
</script>

{#if visible}
    <div class="panel">
        <label for="newlink-input">Destination:<br /></label>
        <input
            class="input"
            id="newlink-input"
            type="text"
            bind:value={link}
            placeholder="A long link"
        /><br />
        <button class="btn btn-primary" onclick={() => addLink(link)}>Add</button>
        <button class="btn btn-error" onclick={() => {visible = false; link = null}}>Cancel</button>
    </div>
{/if}

<style>
    .panel {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        padding: 2rem;
        min-width: 70vw;
        border-radius: 2rem;
        background-color: var(--color-base-200);
        border: 2px solid var(--color-base-content);

        input {
            width: 100%;
        }

        button {
            margin: 1rem 1rem 0 0;
        }
    }
</style>

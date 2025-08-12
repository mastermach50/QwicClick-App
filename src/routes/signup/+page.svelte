<script>
    import { slide } from "svelte/transition";
    import { Button, TextFieldOutlined } from "m3-svelte";
    import "$lib/m3.css";

    let signup_field = { signup_usn: "", signup_eml: "", signup_pwd: "" },
        valid = false;
    let errors = { signup_usn: "", signup_eml: "", signup_pwd: "" };

    const checkFields = () => {
        valid = true;

        if (signup_field.signup_usn.length < 6) {
            valid = false;
            errors.signup_usn = "Username must be at least 6 characters long !";
        } else {
            errors.signup_usn = "";
        }

        if (!signup_field.signup_eml.includes("@")) {
            valid = false;
            errors.signup_eml = "Email must be valid";
        } else {
            errors.signup_eml = "";
        }
        if (signup_field.signup_pwd.length < 8) {
            valid = false;
            errors.signup_pwd = "Password must be at least 8 characters long !";
        } else {
            errors.login_pwd = "";
        }
    };
</script>

<main>
    <div class="leftside">
        <div class="formfield">
            <form class="signup form" on:submit|preventDefault={checkFields}>
                <h3>Sign Up</h3>
                
                <TextFieldOutlined
                    id="signup_usn"
                    type="text"
                    label="Username"
                    bind:value={signup_field.signup_usn}
                /><br />
                <div class="error">{errors.signup_usn}</div><br />
                <TextFieldOutlined
                    id="signup_email"
                    type="email"
                    label="Email"
                    bind:value={signup_field.signup_eml}
                /><br />
                <div class="error">{errors.signup_eml}</div><br />
                
                <TextFieldOutlined
                    id="signup_pwd"
                    type="password"
                    label="Password"
                    bind:value={signup_field.signup_pwd}
                /><br />
                <div class="error">{errors.signup_pwd}</div><br />
                <div class="signup_btn"><Button variant="filled">SIGN UP</Button></div>
                <a href="/login">Already have an account? Click to Login</a>
            </form>
        </div>
    </div>
    <div class="rightside">
        <div class="logo">
            <img src="logo/logo-large.svg" alt="QwicClick Logo" />
        </div>

        <div class="slogans">
            <em>"Shrink Smart.&nbsp; Track Smarter."</em><br />
            <em>"Beyond Short Links — Real-Time Insights."</em><br />
            <strong>powered by Qwic.Click</strong>
        </div>
    </div>
</main>

<style>
    :root {
        --m3-util-background: #ffffff
    }

    main {
        display: grid;
        grid-template-columns: 1fr 1fr;
        margin: 0px auto;
    }

    .leftside {
        display: flex;
        justify-content: center;
        align-items: center;

        width: 50vw;
        height: 100vh;

        background-image: url("/LoginBackground.jpg");
        background-size: cover;
    }

    h3 {
        text-align: center;
        font-weight: bold;
        color: black;
        text-shadow: 1px 1px white;
        font-size: 2rem;
    }

    .rightside {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .slogans {
        text-align: center;
        font-size: 25px;

        strong {
            text-align: right;
        }
    }


    .formfield {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;

        padding: 3rem;

        border: 2px solid white;
        border-radius: 5%;
        box-shadow: 1px 2px 1px white;

        width: 25vw;

        background: white;
    }


    .error {
        color: red;
        font-size: 15px;
        text-align: center;

        margin-bottom: 10px;
    }

    /*input {
        width: 300px;
        height: 25px;

        padding: 5px;

        background: transparent;

        border: 2px solid black;
        border-radius: 10px;

        margin-top: 10px;
        margin-bottom: 20px;
    }*/

    a {
        color: darkblue;
        text-decoration: none;
    }

    .signup_btn {
        text-align: center;
        margin-bottom: 1rem;
    }

    /*Change input text color */
    :global(.m3-container input[type="text"]) {
        color: black;
        
    }
    :global(.m3-container input[type="password"]) {
        color: black;
    }
    :global(.m3-container input[type="email"]) {
        color: black;
    }
    
    /*Change placeholder color */
    :global(.m3-container input[type="text"]::placeholder) {
        color: grey;
    }
    :global(.m3-container input[type="password"]::placeholder) {
        color: grey; 
    }
    :global(.m3-container input[type="email"]::placeholder) {
        color: grey; 
    }
    

    
</style>

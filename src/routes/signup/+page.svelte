<script>

    import { slide } from "svelte/transition";
	import { createEventDispatcher } from "svelte";
    import { Button } from "m3-svelte";


    let signup_field = {signup_usn:"", signup_eml:"", signup_pwd:""}, valid = false;
    let errors = {signup_usn: "", signup_eml: "", signup_pwd:""};

    const checkFields = () => {
        valid = true;

        if (signup_field.signup_usn.length < 6){
            valid = false;
            errors.signup_usn = "Username must be at least 6 characters long !";
        }
        else{
            errors.signup_usn = "";
        }

        if (signup_field.signup_eml.includes('@')){
            valid = false;
            errors.signup_eml = "Email must be valid";
        }

        else{
            errors.signup_eml = "";
        }
        if (signup_field.signup_pwd.length < 8){
            valid = false;
            errors.signup_pwd = "Password must be at least 8 characters long !";
        }

        else{
            errors.login_pwd = "";
        }
    }
</script>

<main>
	<div class="leftside">
		<div class="formfield">
			<form class="signup form" on:submit|preventDefault={checkFields}>
				<h3>Sign Up</h3>
				<label for="signup_usn">Username :</label><br />
				<input id="signup_usn" type="text" placeholder="Choose Username.." bind:value={signup_field.signup_usn}/><br />
                <div class="error">{errors.signup_usn}</div>
				<label for="signup_email">Email :</label><br />
				<input id="signup_email" type="email" placeholder="Enter Email.." bind:value={signup_field.signup_eml}/><br />
                <div class="error">{errors.signup_eml}</div>
				<label for="signup_pwd">Password :</label><br />
				<input id="signup_pwd" type="password" placeholder="Choose Password.." bind:value={signup_field.signup_pwd}/><br />
                <div class="error">{errors.signup_pwd}</div>
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
            <em>"Shrink Smart.&nbsp; Track Smarter."</em><br>
            <em>"Beyond Short Links — Real-Time Insights."</em><br>
            <strong>powered by  Qwic.Click</strong>
        </div>
	</div>
</main>

<style>
     main {
        display: grid;
        grid-template-columns: 1fr 1fr;
        margin: 0px auto;
    }

    .leftside {

        display: flex;
        justify-content: center;
        align-items: center;

        width: 850px;
        height: 700px;
        border: 2px solid;

        background-image: url('Login Background.jpg');
        background-size: cover;
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

        width: 850px;
        height: 700px;
        

        background-image: url('Login Background.jpg');
        background-size: cover;
    }
    

    h3{
        text-align: center;
        font-weight: bold;
        color: black;
        text-shadow: 1px  1px white;
        font-size: 30px;
    }

    .rightside {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        width: 650px;
        height: 700px;
        
    }

    .rightside img{

        width: 400px;
        height: 200px;
    }
    .slogans{
        text-align: center;
        font-size: 25px;
    }

    .slogans strong{
        text-align: right;
    }

    .formfield{
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        
        padding: 10px 30px;

        border: 2px solid white;
        border-radius: 10px;
        box-shadow: 1px 2px 1px white;
        
        width: 50%;
        height: 75%;

        background: white;
    }

    label{
        font-size: 18px;
        text-shadow: 0px 0px 0.3px black;
        margin-top: 10px;
        color: black;
    }
    .error{
        color: red;
        font-size: 15px;
        text-align: center;

        margin-bottom: 10px;
    }

    input {
        width: 300px;
        height: 25px;

        padding: 5px;
        
        background: transparent;
        
        border: 2px solid black;
        border-radius:  10px;

        margin-top: 10px;
        margin-bottom: 20px;
    }

    button{
        width: 150px;
        height: 40px;

        margin-top: 10px;
        margin-bottom: 20px;
        text-align: center;

        font-weight: bold;

        border: 2px solid white;
        border-radius: 10px;
        box-shadow: 1px 2px 3px rgba(0,0,0,0.2);

        cursor: pointer;

        background: red;
        color: white;

        transition: all 0.5s ease-in-out 0s;
    }

    button:hover{

        transform: scale(1);
        background: rgba(0,0,0,1);
        color: white;

        font-weight: bold;
    }

    a {
        color: blue;
        cursor: pointer;
        padding-bottom: 50px;
        
    }



    .signup_btn{
        text-align: center;
    }
</style>


<div class="top">
    <img src="C:\Users\madha\OneDrive\Desktop\Qwic.click logo.jpg" alt="A logo" class="logo" >
    <div class="button-grp">
        <button class="login-btn">Log In</button>
        <button class="signup-btn">Sign Up</button>
    </div>
</div>

<div class="content">
    
</div>

<img src="C:\Users\madha\OneDrive\Desktop\polka dot bg.jpg" alt="Polka dot" style="width: 100%; height: 100%; margin-top: 0px; margin-bottom: 0px;">
<div class="bottom">
    <img src="C:\Users\madha\OneDrive\Desktop\Qwic.click logo.jpg" alt="A logo" class="logo" >
    <div class="copyright">
        <p>&copy; 2025 Qwic.click. All rights reserved.</p>
    </div>
</div>




<style>
    /* Style the header container */
.top {
  display: flex; /* Activates Flexbox */
  justify-content: space-between; /* Pushes logo to left, button to right */
  align-items: center; /* Vertically aligns them in the middle */
  padding: 10px 20px 30px; /* Adds some nice spacing on the sides */
  background-color: #141414; /* A dark background for the header */
}

/* Style the logo image */
.logo {
  width: 210px;
  height: auto; /* Use auto height to maintain aspect ratio */
}

/* Style the sign-up button */
.signup-btn {
  background-color: rgba(191, 172, 255, 1.0);
  border-radius: 8px;
  border: 1px solid #777;
  padding: 10px 30px;
  font-family: 'Nunito', 'Arial Rounded MT Bold', sans-serif;
  color: #333;
  font-weight: bold;
  cursor: pointer; /* Makes it look clickable */
}

.login-btn {
    color: rgba(191, 172, 255, 1.0);
    background-color: transparent; /* Transparent background */
    padding: 10px 30px;
    font-family: 'Nunito', 'Arial Rounded MT Bold', sans-serif;
    font-weight: bold;
    cursor: pointer; /* Makes it look clickable */
    border-color: transparent;
}

.button-grp {
  display: flex; /* Activates Flexbox for the button group */
  gap: 10px; /* Adds space between the buttons */
}

.bottom {
  display: flex; /* Activates Flexbox */
  justify-content: space-between; /* Centers the logo in the footer */
  align-items: center; /* Vertically aligns it in the middle */
  padding: 50px 20px 30px; /* Adds some nice spacing */
  background-color: #141414;
  /*position: fixed;
  bottom: 0; /* Sticks the footer to the bottom */
  left:0; /* Sticks the footer to the left */
  width: 97.5%; /* Ensures the footer spans the full width */
  height: 70px;
}

.copyright {
    color: rgba(191, 172, 255, 1.0);
    display: flex; 
    padding-left: 65%;
    font-family: 'Nunito', 'Arial Rounded MT Bold', sans-serif;
    font-weight: bold;
    text-align: center; /* Centers the text */
    width: 100%; /* Ensures it takes full width */
    right:100%;
}
</style>
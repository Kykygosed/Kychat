<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Connexion - KykyChat</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f0f2f5;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .container {
      background: white;
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      width: 320px;
    }

    h2 {
      text-align: center;
      margin-bottom: 20px;
    }

    input {
      width: 100%;
      padding: 10px;
      margin-top: 10px;
      border-radius: 5px;
      border: 1px solid #ccc;
    }

    button {
      width: 100%;
      margin-top: 20px;
      padding: 10px;
      background-color: #25D366;
      border: none;
      color: white;
      font-weight: bold;
      border-radius: 5px;
      cursor: pointer;
    }

    #status {
      margin-top: 10px;
      text-align: center;
      color: red;
    }
  </style>
</head>
<body>
  <div class="container">
    <h2>Connexion à KykyChat</h2>
    <input type="text" id="pseudo" placeholder="Pseudo">
    <input type="password" id="password" placeholder="Mot de passe">
    <button onclick="login()">Connexion</button>
    <div id="status"></div>
  </div>

  <!-- Firebase -->
  <script src="https://www.gstatic.com/firebasejs/9.22.2/firebase-app-compat.js"></script>
  <script src="https://www.gstatic.com/firebasejs/9.22.2/firebase-database-compat.js"></script>

  <script>
    const firebaseConfig = {
      apiKey: "AIzaSyBPq6Wfxzq02MfK69BFxHm9_FUjDGTmAcw",
      authDomain: "kykychat-24c7f.firebaseapp.com",
      databaseURL: "https://kykychat-24c7f-default-rtdb.firebaseio.com",
      projectId: "kykychat-24c7f",
      storageBucket: "kykychat-24c7f.firebaseapp.com",
      messagingSenderId: "342562811927",
      appId: "1:342562811927:web:0fed1e1f511c4fddcfec52"
    };

    firebase.initializeApp(firebaseConfig);
    const db = firebase.database();

    function login() {
      const pseudo = document.getElementById("pseudo").value.trim();
      const password = document.getElementById("password").value.trim();
      const status = document.getElementById("status");

      if (!pseudo || !password) {
        status.textContent = "Veuillez remplir tous les champs.";
        return;
      }

      const userRef = db.ref("users/" + pseudo);

      userRef.once("value", (snapshot) => {
        if (snapshot.exists()) {
          const data = snapshot.val();
          if (data.password === password) {
            localStorage.setItem("pseudo", pseudo);
            window.location.href = "groupe.html";
          } else {
            status.textContent = "Mot de passe incorrect.";
          }
        } else {
          // Crée un utilisateur avec une couleur unique
          const color = getRandomColor();
          userRef.set({
            password: password,
            color: color
          }, (error) => {
            if (error) {
              status.textContent = "Erreur lors de l'inscription.";
            } else {
              localStorage.setItem("pseudo", pseudo);
              window.location.href = "groupe.html";
            }
          });
        }
      });
    }

    function getRandomColor() {
      const colors = ["#FF5733", "#33FF57", "#3357FF", "#FFC300", "#8E44AD", "#2ECC71", "#1ABC9C", "#E67E22", "#E91E63"];
      return colors[Math.floor(Math.random() * colors.length)];
    }
  </script>
</body>
</html>

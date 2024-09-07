<?php $base_url="http://localhost/eduzilla" ?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="<?php echo $base_url ?>/assets/css/login.css">
</head>
<body>

    <div class="login-container">
        <form action="#" method="post" class="login-form">
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

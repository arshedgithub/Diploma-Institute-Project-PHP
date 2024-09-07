<?php 

    include_once("./../includes/sidenav.php");
    include "./../config/database.php";

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $name = $_POST["name"];
        $username = $_POST["username"];
        $password = $_POST["password"];

        $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

        $query = $conn->prepare("INSERT INTO user (name, username, password) VALUES (?, ?, ?)");
        $query->bind_param("sss", $name, $username, $hashedPassword);
        $query->execute();
    }   

?>

<div class="main-content">
    <h1>Welcome to the Dashboard</h1>
    <p>This is your content area where you can add more information, images, etc.</p>
</div>

<form action="./home.php" method="post" style="padding-left: 120px">  

    <input type="text" name="name">
    <input type="text" name="username">
    <input type="text" name="password">
    <input type="submit" value="Submit">

</form>
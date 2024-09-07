<?php

    session_start();

    // redirect to login page if not logged in
    if (isset($_SESSION['username'])) {
        header("Location: ./templates/home.php");
    } else {
        header("Location: ./templates/login.php");
    }

    exit();

?>
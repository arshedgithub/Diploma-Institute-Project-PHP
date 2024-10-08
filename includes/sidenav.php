<?php 
    session_start();
    $base_url="http://localhost/eduzilla" 
?>

<html>
<head>
    <link rel="stylesheet" href="<?php echo $base_url ?>/assets/css/sidenav.css">
</head>
<body>

    <div class="sidebar">
        <ul>
            <li><a href="<?php echo $base_url ?>/templates/home.php" class="active">Home</a></li>
            <li><a href="<?php echo $base_url ?>/templates/courses.php">Courses</a></li>
            <?php if(isset($_SESSION['role']) && $_SESSION['role'] == 1){ ?>
                <li><a href="<?php echo $base_url ?>/templates/students.php">Students</a></li>
                <li><a href="<?php echo $base_url ?>/templates/lecturers.php">Lecturers</a></li>
            <?php } else { ?>
                <li><a href="<?php echo $base_url ?>/templates/account.php">My Account</a></li>
            <?php }?>
            <li><a href="<?php echo $base_url ?>/templates/logout.php">Logout</a></li>
        </ul>
    </div>

</body>
</html>

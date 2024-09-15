<?php 
    include_once(__DIR__ ."/../includes/sidenav.php");
    include "./../config/database.php";

    $query = $conn->prepare("
        SELECT users.name, users.username, users.email, userstatus.name as user_status, roles.name as role 
        FROM users
        JOIN userstatus ON users.userstatus_id = userstatus.id
        JOIN roles ON users.roles_id = roles.id 
        WHERE users.id = ?");
    
    $query->bind_param("i", $_SESSION['user_id']);
    $query->execute();
    $result = $query->get_result();
    $userData = $result->fetch_assoc();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Account</title>
    <link rel="stylesheet" href="./../assets/css/account.css">
</head>
<body>
    <div class="main-content">
        <div class="profile-card">
            <h1>My Account</h1>
            <h2><?php echo htmlspecialchars($userData['name']); ?></h2>
            <div class="profile-info">
                <p><strong>Role:</strong> <?php echo htmlspecialchars($userData['role']); ?></p>
                <p><strong>User Status:</strong> <?php echo htmlspecialchars($userData['user_status']); ?></p>
                <p><strong>Username:</strong> <?php echo htmlspecialchars($userData['username']); ?></p>
                <p><strong>Email:</strong> <?php echo htmlspecialchars($userData['email']); ?></p>
                <br>
            </div>
            <div class="profile-actions">
                <a href="#">Edit Profile</a>
                <a href="./logout.php">Logout</a>
                <a href="./changePassword.php">Change Password</a>
            </div>
        </div>
    </div>
</body>
</html>

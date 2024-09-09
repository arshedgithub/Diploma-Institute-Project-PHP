<?php 
    // include_once(__DIR__ ."/../includes/sidenav.php");
    include "./../config/database.php";

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        $regno = $_POST["regno"];
        $first_name = $_POST["first_name"];
        $last_name = $_POST["last_name"];
        $middle_name = $_POST["middle_name"];
        $contact = $_POST["contact"];
        $address = $_POST["address"];
        $email = $_POST["email"];
        $fullname = $first_name." ".$last_name;
        $username = $_POST["username"];
        $password = password_hash($_POST["password"], PASSWORD_DEFAULT);

        $conn->begin_transaction();

        try {
            $query = $conn->prepare("INSERT INTO users (name, username, password, email, roles_id) VALUES (?, ?, ?, ?, 2)");
            $query->bind_param("ssss", $fullname, $username, $password, $email);
            $query->execute();

            $user_id = $conn->insert_id;

            $query = $conn->prepare("INSERT INTO lecturers (regno, firstname, lastname, middlename, contact, address, gender_id, user_id, status_id) VALUES (?, ?,?, ?,?, ?, 1, ?, 1)");
            $query->bind_param("sssssss", $regno, $first_name, $last_name, $middle_name, $contact, $address, $user_id);
            $query->execute();

            $conn->commit();
            echo "Admin user and details inserted successfully!";
        } catch (Exception $e) {
            $conn->rollback();
            echo "Error: " . $e->getMessage();
        }
    }   
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lecturer Management</title>
    <link rel="stylesheet" href="<?php echo "./../assets/css/lecturers.css" ?>">
    </head>
<body>

    <div class="main-content">

        <h2>Lecturer Management</h2>

        <button class="btn" id="newLecturerBtn">New Lecturer</button>

        <!-- Popup Modal -->
        <div id="lecturerModal" class="modal">
            <div class="modal-content">
                <span class="close" id="closeModal">&times;</span>
                <form action="./lecturers.php" method="post">
                    <h3>Register New Lecturer</h3>
                    <label for="regno">Registration No.</label>
                    <input type="text" name="regno" required>
                    
                    <label for="first_name">First Name</label>
                    <input type="text" name="first_name" required>

                    <label for="middle_name">Middle Name</label>
                    <input type="text" name="middle_name">

                    <label for="last_name">Last Name</label>
                    <input type="text" name="last_name" required>

                    <label for="contact">Contact</label>
                    <input type="text" name="contact" required>

                    <label for="address">Address</label>
                    <input type="text" name="address" required>

                    <label for="email">Email</label>
                    <input type="email" name="email" required>

                    <label for="username">Username</label>
                    <input type="text" name="username" required>

                    <label for="password">Password</label>
                    <input type="password" name="password" required>

                    <label for="confirm_password">Confirm Password</label>
                    <input type="password" name="confirm_password" required>

                    <input type="submit" value="Register">
                </form>
            </div>
        </div>

        <table>
            <tr>
                <th>Reg. No.</th>
                <th>Name</th>
                <th>Email</th>
                <th>Username</th>
                <th>Address</th>
                <th>Contact</th>
                <th>Gender</th>
                <th>Status</th>
            </tr>
            <?php 
              
                $query = $conn->prepare("
                    SELECT lecturers.*, users.username, users.email, lecturerstatus.name as lecturer_status, gender.name as gender_name 
                    FROM lecturers
                    JOIN users ON lecturers.user_id = users.id
                    JOIN lecturerstatus ON lecturers.status_id = lecturerstatus.id
                    JOIN gender ON lecturers.gender_id = gender.id");
                $query->execute();
                $result = $query->get_result();

                if ($result->num_rows === 0) {
                    echo "<tr><td colspan='8'>No records found.</td></tr>";
                } else {
                    while ($row = $result->fetch_assoc()) {
                        echo "<tr>";
                        echo "<td>" . $row['regno'] . "</td>";
                        echo "<td>" . $row['firstname']. " " . $row['lastname'] . "</td>";
                        echo "<td>" . $row['email'] . "</td>";
                        echo "<td>" . $row['username'] . "</td>";
                        echo "<td>" . $row['address'] . "</td>";
                        echo "<td>" . $row['contact'] . "</td>";
                        echo "<td>" . $row['gender_name'] . "</td>";
                        echo "<td>" . $row['lecturer_status'] . "</td>";
                        echo "</tr>";
                    }
                }
            ?>
        </table>
    </div>

    <script>
        const modal = document.getElementById("lecturerModal");
        const newLecturerBtn = document.getElementById("newLecturerBtn");
        const closeModal = document.getElementById("closeModal");

        newLecturerBtn.onclick = function() {
            modal.style.display = "block";
        }

        closeModal.onclick = function() {
            modal.style.display = "none";
        }

        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>
</html>

<?php 
include_once(__DIR__ ."/../includes/sidenav.php");
include "./../config/database.php";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['diploma_name'])) {
        // Adding a new diploma
        $diploma_name = $_POST["diploma_name"];
        $diploma_description = $_POST["diploma_description"];

        $query = $conn->prepare("INSERT INTO diploma (name, description) VALUES (?, ?)");
        $query->bind_param("ss", $diploma_name, $diploma_description);
        $query->execute();
    } elseif (isset($_POST['course_code'])) {
        // Adding a new course module
        $course_code = $_POST["course_code"];
        $course_title = $_POST["course_title"];
        $credit_value = $_POST["credit_value"];
        $course_description = $_POST["course_description"];
        $diploma_id = $_POST["diploma_id"];
        $coordinator_id = $_POST["coordinator_id"];
        $department_id = $_POST["department_id"];

        $query = $conn->prepare("
            INSERT INTO coursemodule 
            (code, title, creditvalue, description, diploma_id, coordinator_id, department_id) 
            VALUES (?, ?, ?, ?, ?, ?, ?)");
        $query->bind_param("ssisiii", $course_code, $course_title, $credit_value, $course_description, $diploma_id, $coordinator_id, $department_id);
        $query->execute();
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Management</title>
    <link rel="stylesheet" href="<?php echo "./../assets/css/courses.css" ?>">
</head>
<body>

    <div class="main-content">
        <h2>Manage Courses</h2>

        <?php if (isset($_SESSION['role']) && $_SESSION['role'] == 1){ ?>
            <div class="btn-panel">
                <button class="btn" id="newDiplomaBtn">New Diploma</button>
                <button class="btn" id="newCourseModuleBtn">New Course Module</button>
            </div>
        <?php } ?>

        <!-- Modal for Diploma -->
        <div id="diplomaModal" class="modal">
            <div class="modal-content">
                <span class="close" id="closeDiplomaModal">&times;</span>
                <form action="./courses.php" method="post">
                    <h3>Register New Diploma</h3>
                    <label for="diploma_name">Diploma Name</label>
                    <input type="text" name="diploma_name" required>
                    
                    <label for="diploma_description">Description</label>
                    <input type="text" name="diploma_description" required>
                    
                    <input type="submit" value="Register Diploma">
                </form>
            </div>
        </div>

        <!-- Modal for Course Module -->
        <div id="courseModuleModal" class="modal">
            <div class="modal-content">
                <span class="close" id="closeCourseModuleModal">&times;</span>
                <form action="./courses.php" method="post">
                    <h3>Register New Course Module</h3>

                    <label for="course_code">Course Code</label>
                    <input type="text" name="course_code" required>

                    <label for="course_title">Course Title</label>
                    <input type="text" name="course_title" required>

                    <label for="credit_value">Credit Value</label>
                    <input type="number" name="credit_value" min="1" max="8" required>

                    <label for="course_description">Description</label>
                    <input type="text" name="course_description">

                    <label for="diploma_id">Diploma</label>
                    <select name="diploma_id" required>
                        <?php
                            $diploma_query = $conn->query("SELECT id, name FROM diploma");
                            while ($diploma = $diploma_query->fetch_assoc()) {
                                echo "<option value='{$diploma['id']}'>{$diploma['name']}</option>";
                            }
                        ?>
                    </select>

                    <label for="coordinator_id">Course Coordinator</label>
                    <select name="coordinator_id" required> 
                        <?php
                            $coordinator_query = $conn->query("SELECT id, firstname, lastname FROM lecturers");
                            while ($diploma = $coordinator_query->fetch_assoc()) {
                                echo "<option value='{$diploma['id']}'>{$diploma['firstname']} {$diploma['lastname']}</option>";
                            }
                        ?>
                    </select>

                    <label for="department_id">Department</label>
                    <select name="department_id" required> 
                        <?php
                            $coordinator_query = $conn->query("SELECT id, name FROM department");
                            while ($diploma = $coordinator_query->fetch_assoc()) {
                                echo "<option value='{$diploma['id']}'>{$diploma['name']}</option>";
                            }
                        ?>
                    </select>

                    <input type="submit" value="Register Course Module">
                </form>
            </div>
        </div>

        <?php

        $diplomas_query = $conn->query("SELECT id, name, description FROM diploma");

        if ($diplomas_query->num_rows > 0) {
            while ($diploma = $diplomas_query->fetch_assoc()) {
                echo "<div class='diploma-section'>";
                echo "<h2>" . $diploma['name'] . "</h2>";
                echo "<p>" . $diploma['description'] . "</p>";

                // Fetch the course modules related to this diploma
                $diploma_id = $diploma['id'];
                $courses_query = $conn->prepare("
                    SELECT coursemodule.code, coursemodule.title, coursemodule.creditvalue, 
                    coursemodule.description, lecturers.firstname, lecturers.lastname, department.name AS department_name 
                    FROM coursemodule
                    JOIN lecturers ON coursemodule.coordinator_id = lecturers.id
                    JOIN department ON coursemodule.department_id = department.id
                    WHERE coursemodule.diploma_id = ?
                ");
                $courses_query->bind_param("i", $diploma_id);
                $courses_query->execute();
                $courses_result = $courses_query->get_result();

                if ($courses_result->num_rows > 0) {
                    echo "<table>";
                    echo "<tr>
                        <th>Course Code</th>
                        <th>Title</th>
                        <th>Credits</th>
                        <th>Description</th>
                        <th>Coordinator</th>
                        <th>Department</th>
                    </tr>";

                    while ($course = $courses_result->fetch_assoc()) {
                        echo "<tr>";
                        echo "<td>" . $course['code'] . "</td>";
                        echo "<td>" . $course['title'] . "</td>";
                        echo "<td>" . $course['creditvalue'] . "</td>";
                        echo "<td>" . $course['description'] . "</td>";
                        echo "<td>" . $course['firstname'] . " " . $course['lastname'] . "</td>";
                        echo "<td>" . $course['department_name'] . "</td>";
                        echo "</tr>";
                    }

                    echo "</table>";
                } else {
                    echo "<p>No course modules available for this diploma.</p>";
                }

                echo "</div>";
            }
        } else {
            echo "<p>No diplomas found.</p>";
        }
    ?>

    </div>

    <script>
        // Modal handling scripts
        const diplomaModal = document.getElementById("diplomaModal");
        const newDiplomaBtn = document.getElementById("newDiplomaBtn");
        const closeDiplomaModal = document.getElementById("closeDiplomaModal");

        newDiplomaBtn.onclick = function() {
            diplomaModal.style.display = "block";
        }
        closeDiplomaModal.onclick = function() {
            diplomaModal.style.display = "none";
        }

        const courseModuleModal = document.getElementById("courseModuleModal");
        const newCourseModuleBtn = document.getElementById("newCourseModuleBtn");
        const closeCourseModuleModal = document.getElementById("closeCourseModuleModal");

        newCourseModuleBtn.onclick = function() {
            courseModuleModal.style.display = "block";
        }
        closeCourseModuleModal.onclick = function() {
            courseModuleModal.style.display = "none";
        }

        window.onclick = function(event) {
            if (event.target == diplomaModal) {
                diplomaModal.style.display = "none";
            } else if (event.target == courseModuleModal) {
                courseModuleModal.style.display = "none";
            }
        }
    </script>
</body>
</html>

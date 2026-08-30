<?php
session_start();

if (isset($_SESSION["user_id"]) && ($_SESSION["role"] ?? "") === "admin") {
    header("Location: view/admin_dashboard.php");
} elseif (isset($_SESSION["user_id"])) {
    header("Location: view/home.php");
} else {
    header("Location: view/login.php");
}
exit;

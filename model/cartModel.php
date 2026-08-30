<?php
require_once __DIR__ . '/db.php';

// ইউজারের কার্টের সব প্রোডাক্ট রিড করা
function getCartItems($userId) {
    $conn = getConnection();
    // ডাটাবেজ স্কিমা অনুযায়ী m.vendor_name এবং m.image_path ব্যবহার করা হয়েছে
    $sql = "SELECT c.*, m.name, m.price, m.vendor_name, m.image_path 
            FROM cart c 
            JOIN medicines m ON c.medicine_id = m.id 
            WHERE c.user_id = ?";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "i", $userId);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    return mysqli_fetch_all($result, MYSQLI_ASSOC);
}

// কার্টে নতুন মেডিসিন যোগ করা বা কোয়ান্টিটি বাড়ানো
function addToCart($userId, $medicineId, $quantity) {
    $conn = getConnection();
    
    $sql = "SELECT id, quantity FROM cart WHERE user_id = ? AND medicine_id = ?";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "ii", $userId, $medicineId);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    $existing = mysqli_fetch_assoc($result);

    if ($existing) {
        $newQty = $existing['quantity'] + $quantity;
        $updateSql = "UPDATE cart SET quantity = ? WHERE id = ?";
        $updateStmt = mysqli_prepare($conn, $updateSql);
        mysqli_stmt_bind_param($updateStmt, "ii", $newQty, $existing['id']);
        return mysqli_stmt_execute($updateStmt);
    } else {
        $insertSql = "INSERT INTO cart (user_id, medicine_id, quantity) VALUES (?, ?, ?)";
        $insertStmt = mysqli_prepare($conn, $insertSql);
        mysqli_stmt_bind_param($insertStmt, "iii", $userId, $medicineId, $quantity);
        return mysqli_stmt_execute($insertStmt);
    }
}

// কার্টের কোয়ান্টিটি আপডেট করা
function updateCartQuantity($cartId, $quantity) {
    $conn = getConnection();
    $sql = "UPDATE cart SET quantity = ? WHERE id = ?";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "ii", $quantity, $cartId);
    return mysqli_stmt_execute($stmt);
}

// কার্ট থেকে আইটেম রিমুভ করা
function removeFromCart($cartId) {
    $conn = getConnection();
    $sql = "DELETE FROM cart WHERE id = ?";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "i", $cartId);
    return mysqli_stmt_execute($stmt);
}

// কার্ট সম্পূর্ণ খালি করা
function clearCart($userId) {
    $conn = getConnection();
    $sql = "DELETE FROM cart WHERE user_id = ?";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "i", $userId);
    return mysqli_stmt_execute($stmt);
}
// ইউজারের কার্টে মোট কতগুলো আইটেম আছে তার সংখ্যা বের করা
function getCartCount($userId) {
    $conn = getConnection();
    $sql = "SELECT SUM(quantity) AS total FROM cart WHERE user_id = ?";
    $stmt = mysqli_prepare($conn, $sql);
    mysqli_stmt_bind_param($stmt, "i", $userId);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    $row = mysqli_fetch_assoc($result);
    return (int)($row['total'] ?? 0);
}
?>

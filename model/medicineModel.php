<?php
require_once __DIR__ . "/db.php";

function getAllCategories(): array
{
    global $con;
    $sql = "SELECT id, name, category_type FROM categories ORDER BY category_type, name";
    $result = mysqli_query($con, $sql);

    $categories = [];
    if (!$result) {
        return $categories;
    }

    while ($row = mysqli_fetch_assoc($result)) {
        $categories[] = $row;
    }

    return $categories;
}

function getAllVendors(): array
{
    global $con;
    $sql = "SELECT DISTINCT vendor_name FROM medicines ORDER BY vendor_name";
    $result = mysqli_query($con, $sql);

    $vendors = [];
    if (!$result) {
        return $vendors;
    }

    while ($row = mysqli_fetch_assoc($result)) {
        $vendors[] = $row["vendor_name"];
    }

    return $vendors;
}

function searchMedicines(string $searchText, string $vendor, string $genre, string $type): array
{
    global $con;

    // ১. মূল SQL কুয়েরি যেখানে টেবিল এলিয়াস দিয়ে কলামগুলো সিলেক্ট করা হয়েছে
    $sql = "SELECT
                m.id,
                m.name,
                m.vendor_name,
                m.price,
                m.availability,
                m.description,
                m.image_path,
                c.name AS category_name,
                c.category_type
            FROM medicines m
            INNER JOIN categories c ON c.id = m.category_id
            WHERE 1=1";

    $params = [];
    $types = "";

    // ২. ডাইনামিক ফিল্টারিং নিয়ম (যা ডাটাবেজের ওপর প্রেশার কমাবে এবং m.availability এররটি মুক্ত রাখবে)
    if ($searchText !== '') {
        $sql .= " AND m.name LIKE ?";
        $params[] = "%" . $searchText . "%";
        $types .= "s";
    }

    if ($vendor !== '') {
        $sql .= " AND m.vendor_name = ?";
        $params[] = $vendor;
        $types .= "s";
    }

    if ($genre !== '') {
        // genre কলামের আইডি বা নাম চেক করার লজিক
        $sql .= " AND (CAST(c.id AS CHAR) = ? OR c.name = ?)";
        $params[] = $genre;
        $params[] = $genre;
        $types .= "ss";
    }

    if ($type !== '') {
        $sql .= " AND c.category_type = ?";
        $params[] = $type;
        $types .= "s";
    }

    $sql .= " ORDER BY c.category_type, c.name, m.name";

    // ৩. স্টেটমেন্ট প্রিপেয়ার এবং এক্সিকিউট
    $stmt = mysqli_prepare($con, $sql);

    if ($types !== '') {
        mysqli_stmt_bind_param($stmt, $types, ...$params);
    }

    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    $medicines = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $medicines[] = $row;
    }

    mysqli_stmt_close($stmt);
    return $medicines;
}
?>

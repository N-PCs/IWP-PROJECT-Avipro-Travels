<?php
session_start();
require_once 'php/config.php';

// Check if already logged in
if (isset($_SESSION['admin_logged_in']) && $_SESSION['admin_logged_in'] === true) {
    header('Location: admin/admin-panel.php');
    exit;
}

// Handle login form submission
$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';
    
    if (!empty($username) && !empty($password)) {
        $pdo = getDBConnection();
        $stmt = $pdo->prepare("SELECT * FROM admin_users WHERE username = ?");
        $stmt->execute([$username]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($user && password_verify($password, $user['password_hash'])) {
            $_SESSION['admin_logged_in'] = true;
            $_SESSION['admin_id'] = $user['id'];
            $_SESSION['admin_username'] = $user['username'];
            $_SESSION['admin_email'] = $user['email'];
            
            header('Location: admin/admin-panel.php');
            exit;
        } else {
            $error = 'Invalid username or password!';
        }
    } else {
        $error = 'Please enter both username and password!';
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Avipro Travels</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <div class="logo" style="text-align: center; margin-bottom: 30px;">
                <h1>Avipro<span>Travels</span></h1>
                <p style="color: var(--gray); margin-top: 10px;">Admin Panel</p>
            </div>
            
            <h2>Admin Login</h2>
            
            <?php if (!empty($error)): ?>
                <div class="error-message" style="background: #fce8e6; color: #ea4335; padding: 10px; border-radius: 4px; margin-bottom: 20px;">
                    <?php echo htmlspecialchars($error); ?>
                </div>
            <?php endif; ?>
            
            <form method="POST" action="">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" class="form-control" required value="<?php echo htmlspecialchars($_POST['username'] ?? ''); ?>">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>
                <button type="submit" class="btn" style="width: 100%;">Login</button>
            </form>
            
            <div style="text-align: center; margin-top: 20px;">
                <a href="index.html" style="color: var(--primary);">← Back to Website</a>
            </div>
            
            <!-- Demo Credentials -->
            <div style="background: #f8f9fa; padding: 15px; border-radius: 4px; margin-top: 20px; font-size: 0.9rem;">
                <strong>Demo Credentials:</strong><br>
                Username: admin<br>
                Password: admin123
            </div>
        </div>
    </div>
</body>
</html>
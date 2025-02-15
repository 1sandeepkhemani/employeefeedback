<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ThankYou.aspx.cs" Inherits="employeefeedback.ThankYou" %>



<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thank You</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lottie-web/5.9.4/lottie.min.js"></script>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: #f8f9fa;
            overflow: hidden;
        }
        .thank-you-container {
            text-align: center;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            position: relative;
            z-index: 10;
        }
        #success-animation {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: 5;
            background: white;
        }
        .btn-close-all {
            background: red;
            color: white;
            border: none;
            padding: 12px 18px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }
        .btn-close-all:hover {
            background: darkred;
        }
    </style>
</head>
<body>

    <form runat="server">
        <div id="success-animation"></div> <!-- Full-screen animation -->
        
        <div class="thank-you-container" id="thankYouMessage" style="display: none;">
            <h2>Thank You!</h2>
            <p>Your feedback has been successfully submitted.</p>
            <asp:Button ID="btnClose" runat="server" CssClass="btn-close-all mt-3" Text="Close" OnClientClick="closeAllWindows(); return false;" />
        </div>
    </form>

    <script>
        // Load full-screen Lottie animation
        var animation = lottie.loadAnimation({
            container: document.getElementById('success-animation'),
            renderer: 'svg',
            loop: false,
            autoplay: true,
            path: 'https://assets10.lottiefiles.com/packages/lf20_jbrw3hcz.json'
        });

        // Hide animation and show message after animation completes
        animation.addEventListener('complete', function () {
            document.getElementById('success-animation').style.display = 'none';
            document.getElementById('thankYouMessage').style.display = 'block';
        });

        // Close all open tabs/windows
        function closeAllWindows() {
            var win = window.open('', '_self');
            win.close();
        }
    </script>

</body>
</html>




<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="lab_CSDL.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Demo Quản Lý Nhân Viên</title>
    <style type="text/css">
        /* ✨ BẮT ĐẦU CSS ĐÃ CẢI THIỆN VÀ HIỆN ĐẠI ✨ */

        /* Định nghĩa các biến CSS (Custom Properties) */
        :root {
            --primary-color: #007bff; /* Xanh dương cho tiêu đề, nút */
            --secondary-color: #6c757d; /* Màu xám cho chữ phụ */
            --background-color: #f8f9fa; /* Nền sáng */
            --card-background: #ffffff; /* Nền panel/card */
            --border-color: #dee2e6;
            --shadow-light: 0 4px 8px rgba(0, 0, 0, 0.05);
            --shadow-hover: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background-color: var(--background-color);
            margin: 0;
            padding: 0;
            display: flex; /* Căn giữa nội dung */
            justify-content: center;
            align-items: flex-start; /* Giữ nội dung ở phía trên */
            min-height: 100vh;
        }
        
        #form1 {
            width: 100%;
        }

        h1 {
            color: var(--primary-color);
            margin-top: 30px;
            margin-bottom: 10px;
            text-align: center;
            font-size: 2.2em;
            font-weight: 300;
        }

        hr {
            border: 0;
            height: 1px;
            background-color: var(--border-color);
            width: 50%;
            margin-bottom: 30px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Container chính (Panel1) - Trông như một Card */
        #Panel1 {
            border: 1px solid var(--border-color);
            padding: 20px;
            width: 300px;
            margin: 30px auto;
            background-color: var(--card-background);
            box-shadow: var(--shadow-light);
            border-radius: 12px;
            transition: box-shadow 0.3s ease-in-out;
        }

        #Panel1:hover {
            box-shadow: var(--shadow-hover);
        }

        /* Tiêu đề Chức năng */
        #Panel1 .auto-style1 {
            font-weight: 600;
            font-size: 1.3em;
            margin-bottom: 20px;
            color: #333;
            text-transform: uppercase;
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 8px;
            text-align: center;
        }

        /* Định kiểu cho các mục menu */
        #Panel1 div div {
            margin-bottom: 5px;
        }
        
        /* Menu Item Container (để xử lý hover tốt hơn) */
        #Panel1 > div:not(.auto-style1) { 
            display: flex;
            align-items: center;
            padding: 10px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.2s ease, color 0.2s ease;
        }
        
        #Panel1 > div:not(.auto-style1):hover {
            background-color: rgba(0, 123, 255, 0.1);
        }

        /* Link Menu */
        #form1 div a {
            text-decoration: none;
            color: #333;
            flex-grow: 1; /* Cho link chiếm phần còn lại */
            margin-left: 10px;
            font-size: 1.05em;
            font-weight: 400;
        }
        
        #Panel1 > div:not(.auto-style1):hover a {
            color: var(--primary-color);
        }


        /* Icon (Image) */
        #form1 div img {
            width: 24px;
            height: 24px;
            vertical-align: middle;
        }
        
        /* Xóa bỏ khoảng trắng dư thừa do <br /> nếu có */
        #form1 div div br {
            display: none;
        }
        
        /* Xóa style cũ không cần thiết nếu đã định kiểu lại */
        .auto-style1 {
            text-align: center;
        }
        
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1><strong>DEMO QUẢN LÝ NHÂN VIÊN</strong></h1>
            <hr />
            <asp:Panel ID="Panel1" runat="server">
                <div class="auto-style1">
                    CHỨC NĂNG
                </div>
                <div>
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/icon_users.gif" />
                    <a href="qlNhanVien.aspx">Quản lý nhân viên</a>
                </div>
                <div>
                    <asp:Image ID="Image2" runat="server" ImageUrl="~/Images/User.gif" />
                    <a href="qlPhongBan.aspx">Quản lý phòng ban</a>
                </div>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
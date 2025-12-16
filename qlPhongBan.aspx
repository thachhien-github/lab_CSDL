<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="qlPhongBan.aspx.cs" Inherits="lab_CSDL.qlPhongBan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản Lý Phòng Ban</title>
    <style type="text/css">
        :root {
            --primary-color: #3498db; /* Xanh dương */
            --header-bg: #3498db; /* Nền đầu bảng */
            --border-color: #ddd;
            --button-bg: #e9e9e9;
            --hover-bg: #f5f5ff;
        }

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            background-color: #f9f9f9;
        }

        #form1 {
            width: 90%;
            max-width: 1200px; /* Giới hạn chiều rộng tối đa */
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            color: #333;
            font-size: 1.8em;
            margin-bottom: 10px;
        }

        hr {
            border: 0;
            height: 1px;
            background-color: var(--border-color);
            width: 80%;
            margin-bottom: 20px;
        }

        /* Định dạng DropDownList */
        .dropdown-container {
            display: flex;
            align-items: center;
            justify-content: center; /* Căn giữa toàn bộ cụm chọn */
            margin: 20px 0;
            flex-direction: column; /* Đặt nhãn và dropdown trên 2 dòng */
        }

        .dropdown-label {
            margin-bottom: 5px; /* Khoảng cách giữa nhãn và dropdown */
            font-weight: bold;
            color: #555;
            font-size: 0.9em;
            border-bottom: 1px solid var(--border-color); /* Đường gạch dưới giống hình */
            padding-bottom: 3px;
        }

        .dropdown-style {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1em;
            width: 250px; /* Chiều rộng cho DropDownList */
            max-width: 100%;
        }

        /* Định dạng GridView */
        .gv-style {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid var(--border-color);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-top: 20px; /* Khoảng cách với DropDownList */
        }

            /* Tiêu đề bảng */
            .gv-style th {
                background-color: var(--header-bg);
                color: #fff;
                font-weight: bold;
                padding: 10px 8px;
                border: 1px solid var(--border-color);
                text-align: center;
                font-size: 0.95em;
            }

            /* Các ô dữ liệu */
            .gv-style td {
                padding: 8px;
                border: 1px solid var(--border-color);
                text-align: center; /* Căn giữa dữ liệu */
                font-size: 0.9em;
            }

                /* Căn trái cho Họ và Tên nhân viên (cột 2 và 3) */
                .gv-style td:nth-child(2), .gv-style td:nth-child(3) {
                    text-align: left;
                }

            /* Dòng xen kẽ */
            .gv-style tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .gv-style tr:nth-child(odd) {
                background-color: #fff;
            }

            /* Hiệu ứng Hover */
            .gv-style tr:hover {
                background-color: var(--hover-bg);
            }

            /* Định dạng nút Delete */
            .gv-style input[type="submit"] {
                padding: 4px 8px;
                border: 1px solid #999;
                border-radius: 4px;
                cursor: pointer;
                font-size: 0.85em;
                transition: background-color 0.2s;
                background-color: var(--button-bg);
            }

                .gv-style input[type="submit"]:hover {
                    background-color: #ddd;
                }

        .link-quay-lai {
            text-align: center;
            margin-top: 20px;
        }

            .link-quay-lai a {
                text-decoration: none;
                color: var(--primary-color);
            }

                .link-quay-lai a:hover {
                    text-decoration: underline;
                }

        /* Message Box */
        .message {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
            font-weight: bold;
            text-align: center;
        }

            .message.success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .message.error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
    </style>
    <script type="text/javascript">
        function ConfirmDelete() {
            return confirm("Bạn có chắc chắn muốn xóa nhân viên này không?");
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">

        <!-- MESSAGE -->
        <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>

        <!-- DATA -->
        <asp:SqlDataSource ID="DataPhongBan" runat="server"
            ConnectionString="<%$ ConnectionStrings:QLNhanVienConnectionString %>"
            SelectCommand="SELECT MaPhong, TenPhong FROM Phong ORDER BY TenPhong" />

        <asp:SqlDataSource ID="DataNhanVienTheoPhong" runat="server"
            ConnectionString="<%$ ConnectionStrings:QLNhanVienConnectionString %>"
            SelectCommand="SELECT MaNV, HoNV, TenNV, Phai, NgaySinh, NoiSinh, MaPhong 
                       FROM NhanVien WHERE MaPhong = @MaPhong"
            DeleteCommand="DELETE FROM NhanVien WHERE MaNV = @MaNV">

            <SelectParameters>
                <asp:ControlParameter Name="MaPhong" ControlID="ddlPhongBan"
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>

            <DeleteParameters>
                <asp:Parameter Name="MaNV" Type="Int32" />
            </DeleteParameters>
        </asp:SqlDataSource>

        <h1>QUẢN LÝ PHÒNG BAN</h1>

        <div class="dropdown-container">
            <span class="dropdown-label">Phòng ban</span>
            <asp:DropDownList ID="ddlPhongBan" runat="server"
                DataSourceID="DataPhongBan"
                DataTextField="TenPhong"
                DataValueField="MaPhong"
                AutoPostBack="True"
                CssClass="dropdown-style" />
        </div>

        <!-- GRID -->
        <asp:GridView ID="dgvNhanVien" runat="server"
            DataSourceID="DataNhanVienTheoPhong"
            AutoGenerateColumns="False"
            CssClass="gv-style"
            DataKeyNames="MaNV"
            AllowPaging="True"
            OnRowDeleting="dgvNhanVien_RowDeleting"
            OnRowDataBound="dgvNhanVien_RowDataBound">

            <Columns>
                <asp:BoundField DataField="MaNV" HeaderText="Mã NV" />
                <asp:BoundField DataField="HoNV" HeaderText="Họ NV" />
                <asp:BoundField DataField="TenNV" HeaderText="Tên NV" />

                <asp:TemplateField HeaderText="Phái">
                    <ItemTemplate>
                        <%# Convert.ToBoolean(Eval("Phai")) ? "Nam" : "Nữ" %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="NgaySinh" HeaderText="Ngày sinh"
                    DataFormatString="{0:dd/MM/yyyy}" />
                <asp:BoundField DataField="NoiSinh" HeaderText="Nơi sinh" />
                <asp:BoundField DataField="MaPhong" HeaderText="Mã phòng" />

                <asp:CommandField ShowDeleteButton="True"
                    ButtonType="Link"
                    DeleteText="Xóa" />
            </Columns>
        </asp:GridView>


        <div class="link-quay-lai">
            <a href="Default.aspx"><strong>Quay lại trang chủ</strong></a>
        </div>

    </form>
</body>
</html>

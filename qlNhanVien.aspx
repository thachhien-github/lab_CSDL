<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="qlNhanVien.aspx.cs" Inherits="lab_CSDL.qlNhanVien" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Danh Sách Nhân Viên</title>
    <style type="text/css">

        :root {
            --primary-color: #3498db; /* Xanh dương */
            --header-bg: #3498db; /* Nền đầu bảng */
            --border-color: #ddd;
            --button-bg: #e9e9e9;
            --hover-bg: #f5f5ff;
            --success-color: #2ecc71;
            --error-color: #e74c3c;
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

        /* Định dạng GridView */
        .gv-style {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid var(--border-color);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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
        
        /* Căn trái cho Tên nhân viên */
        .gv-style td:nth-child(2), .gv-style td:nth-child(3), .gv-style td:nth-child(6) { 
            text-align: left;
        }

        /* Dòng xen kẽ (màu trắng và màu hơi ngả) */
        .gv-style tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .gv-style tr:nth-child(odd) {
            background-color: #fff;
        }
        
        /* Hiệu ứng Hover */
        .gv-style tr:hover {
            background-color: var(--hover-bg); /* Màu xanh nhạt khi hover */
        }

        /* Định dạng nút Edit/Delete */
        .gv-style input[type="submit"] {
            padding: 4px 8px;
            border: 1px solid #999;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.85em;
            transition: background-color 0.2s;
            background-color: var(--button-bg);
            margin: 0 2px;
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
            font-weight: bold;
        }
        
        .link-quay-lai a:hover {
            text-decoration: underline;
        }

        /* Định dạng form thêm nhân viên */
        .add-employee-form {
            background-color: #f0f0f0;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
        }

        .add-employee-form h2 {
            margin-top: 0;
            color: #333;
            font-size: 1.2em;
            border-bottom: 1px dashed #ccc;
            padding-bottom: 5px;
            margin-bottom: 10px;
        }

        .form-group {
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            flex-wrap: wrap; /* Cho phép xuống dòng trên màn hình nhỏ */
        }

        .form-group label {
            width: 150px; /* Chiều rộng cố định cho nhãn */
            font-weight: bold;
            color: #555;
            flex-shrink: 0;
        }

        .form-group input[type="text"], 
        .form-group input[type="date"],
        .form-group select {
            flex-grow: 1;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            max-width: 300px; /* Giới hạn chiều rộng input */
        }
        
        .form-group input[type="checkbox"] {
            margin-left: 0;
            margin-right: 5px;
        }

        .add-employee-form .btn-container {
            text-align: right;
            margin-top: 15px;
        }

        .add-employee-form .btn-container input[type="submit"] {
            padding: 8px 15px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s;
        }

        .add-employee-form .btn-container input[type="submit"]:hover {
            background-color: #2980b9;
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
        // Hàm xác nhận trước khi xóa
        function ConfirmDelete() {
            return confirm("Bạn có chắc chắn muốn xóa nhân viên này không?");
        }
    </script>
</head>
<body>
<form id="form1" runat="server">

    <!-- DATA -->
    <asp:SqlDataSource ID="DataqlNhanVien" runat="server"
        ConnectionString="<%$ ConnectionStrings:QLNhanVienConnectionString %>"
        SelectCommand="SELECT MaNV, HoNV, TenNV, Phai, NgaySinh, NoiSinh, MaPhong FROM NhanVien"
        InsertCommand="INSERT INTO NhanVien(HoNV,TenNV,Phai,NgaySinh,NoiSinh,MaPhong)
                       VALUES(@HoNV,@TenNV,@Phai,@NgaySinh,@NoiSinh,@MaPhong)"
        UpdateCommand="UPDATE NhanVien SET
                       HoNV=@HoNV, TenNV=@TenNV, Phai=@Phai,
                       NgaySinh=@NgaySinh, NoiSinh=@NoiSinh, MaPhong=@MaPhong
                       WHERE MaNV=@MaNV"
        DeleteCommand="DELETE FROM NhanVien WHERE MaNV=@MaNV">

        <InsertParameters>
            <asp:Parameter Name="HoNV" />
            <asp:Parameter Name="TenNV" />
            <asp:Parameter Name="Phai" />
            <asp:Parameter Name="NgaySinh" />
            <asp:Parameter Name="NoiSinh" />
            <asp:Parameter Name="MaPhong" />
        </InsertParameters>

        <UpdateParameters>
            <asp:Parameter Name="HoNV" />
            <asp:Parameter Name="TenNV" />
            <asp:Parameter Name="Phai" />
            <asp:Parameter Name="NgaySinh" />
            <asp:Parameter Name="NoiSinh" />
            <asp:Parameter Name="MaPhong" />
            <asp:Parameter Name="MaNV" />
        </UpdateParameters>

        <DeleteParameters>
            <asp:Parameter Name="MaNV" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="DataPhong" runat="server"
        ConnectionString="<%$ ConnectionStrings:QLNhanVienConnectionString %>"
        SelectCommand="SELECT MaPhong, TenPhong FROM Phong">
    </asp:SqlDataSource>

    <h1>DANH SÁCH NHÂN VIÊN</h1>

    <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>

    <!-- FORM THÊM -->
    <div class="add-employee-form">
        <h3>Thêm nhân viên</h3>

        <div class="form-group">
            <label>Họ NV:</label>
            <asp:TextBox ID="txtHoNV" runat="server" />
        </div>

        <div class="form-group">
            <label>Tên NV:</label>
            <asp:TextBox ID="txtTenNV" runat="server" />
        </div>

        <div class="form-group">
            <label>Phái:</label>
            <asp:CheckBox ID="chkPhai" runat="server" Text="Nam" />
        </div>

        <div class="form-group">
            <label>Ngày sinh:</label>
            <asp:TextBox ID="txtNgaySinh" runat="server" TextMode="Date" />
        </div>

        <div class="form-group">
            <label>Nơi sinh:</label>
            <asp:TextBox ID="txtNoiSinh" runat="server" />
        </div>

        <div class="form-group">
            <label>Phòng ban:</label>
            <asp:DropDownList ID="ddlMaPhong" runat="server"
                DataSourceID="DataPhong"
                DataTextField="TenPhong"
                DataValueField="MaPhong">
                <asp:ListItem Value="">-- Chọn phòng --</asp:ListItem>
            </asp:DropDownList>
        </div>

        <asp:Button ID="btnAdd" runat="server" Text="Thêm nhân viên" OnClick="btnAdd_Click" Height="40px" style="color: #FFFFFF; font-weight: 700; background-color: #3399FF" Width="137px" BorderStyle="None" />
    </div>

    <!-- GRID -->
    <asp:GridView ID="dgvNhanVien" runat="server"
        DataSourceID="DataqlNhanVien"
        AutoGenerateColumns="False"
        CssClass="gv-style"
        DataKeyNames="MaNV"
        AllowPaging="True"
        PageSize="10"
        OnPageIndexChanging="dgvNhanVien_PageIndexChanging"
        OnRowEditing="dgvNhanVien_RowEditing"
        OnRowCancelingEdit="dgvNhanVien_RowCancelingEdit"
        OnRowUpdating="dgvNhanVien_RowUpdating"
        OnRowDeleting="dgvNhanVien_RowDeleting"
        OnRowDataBound="dgvNhanVien_RowDataBound">

        <Columns>
            <asp:BoundField DataField="MaNV" HeaderText="Mã NV" ReadOnly="True" />
            <asp:BoundField DataField="HoNV" HeaderText="Họ NV" />
            <asp:BoundField DataField="TenNV" HeaderText="Tên NV" />

            <asp:TemplateField HeaderText="Giới tính">
                <ItemTemplate>
                    <%# Convert.ToBoolean(Eval("Phai")) ? "Nam" : "Nữ" %>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chkEditPhai" runat="server"
                        Checked='<%# Bind("Phai") %>' Text="Nam" />
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="NgaySinh" HeaderText="Ngày sinh" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="NoiSinh" HeaderText="Nơi sinh" />

            <asp:TemplateField HeaderText="Phòng ban">
                <ItemTemplate>
                    <%# Eval("MaPhong") %>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlEditPhong" runat="server"
                        DataSourceID="DataPhong"
                        DataTextField="TenPhong"
                        DataValueField="MaPhong"
                        SelectedValue='<%# Bind("MaPhong") %>' />
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:CommandField ShowEditButton="True" ButtonType="Link" EditText="Sửa"/>
            <asp:CommandField ShowDeleteButton="True" ButtonType="Link" DeleteText="Xóa"/>
        </Columns>
    </asp:GridView>

    <div class="link-quay-lai">
    <a href="Default.aspx">Quay lại trang chủ</a>
</div>
</form>
</body>
</html>
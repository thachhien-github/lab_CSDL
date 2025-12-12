<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="qlNhanVien.aspx.cs" Inherits="lab_CSDL.qlNhanVien" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Danh Sách Nhân Viên</title>
    <style type="text/css">
        /* ✨ CSS ĐỂ PHÙ HỢP VỚI GIAO DIỆN TRONG HÌNH ✨ */

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
        .gv-style td:nth-child(3), .gv-style td:nth-child(4) { 
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:SqlDataSource ID="DataqlNhanVien" runat="server" 
            ConnectionString="<%$ ConnectionStrings:QLNhanVienConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:QLNhanVienConnectionString.ProviderName %>" 
            SelectCommand="SELECT MaNV, HoNV, TenNV, Phai, NgaySinh, NoiSinh, MaPhong FROM NhanVien"
            
            DeleteCommand="DELETE FROM NhanVien WHERE MaNV = @MaNV"
            UpdateCommand="UPDATE NhanVien SET HoNV = @HoNV, TenNV = @TenNV, Phai = @Phai, NgaySinh = @NgaySinh, NoiSinh = @NoiSinh, MaPhong = @MaPhong WHERE MaNV = @MaNV">
            
            <DeleteParameters>
                <asp:Parameter Name="MaNV" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="HoNV" Type="String" />
                <asp:Parameter Name="TenNV" Type="String" />
                <asp:Parameter Name="Phai" Type="Boolean" />
                <asp:Parameter Name="NgaySinh" Type="DateTime" />
                <asp:Parameter Name="NoiSinh" Type="String" />
                <asp:Parameter Name="MaPhong" Type="Int32" />
                <asp:Parameter Name="MaNV" Type="Int32" /> 
            </UpdateParameters>
            
        </asp:SqlDataSource>
        
        <div>
            <h1>DANH SÁCH NHÂN VIÊN</h1>
            <hr />
            
            <asp:GridView ID="GridView1" runat="server"
                DataSourceID="DataqlNhanVien"
                AutoGenerateColumns="False" 
                CssClass="gv-style"
                DataKeyNames="MaNV"
                AllowPaging="True" 
                
                OnRowDeleting="GridView1_RowDeleting"
                OnRowEditing="GridView1_RowEditing"
                OnRowCancelingEdit="GridView1_RowCancelingEdit"
                OnRowUpdating="GridView1_RowUpdating" > 
                
                <Columns>
                    <asp:BoundField DataField="MaNV" HeaderText="Mã nhân viên" SortExpression="MaNV" ReadOnly="True" ItemStyle-Width="80px" />
                    <asp:BoundField DataField="HoNV" HeaderText="Họ nhân viên" SortExpression="HoNV" />
                    <asp:BoundField DataField="TenNV" HeaderText="Tên nhân viên" SortExpression="TenNV" />
                    
                    <asp:CheckBoxField DataField="Phai" HeaderText="Phái" ItemStyle-Width="50px" />
                    
                    <asp:BoundField DataField="NgaySinh" HeaderText="Ngày sinh" SortExpression="NgaySinh" DataFormatString="{0:dd/MM/yyyy}" />
                    
                    <asp:BoundField DataField="NoiSinh" HeaderText="Nơi sinh" SortExpression="NoiSinh" />
                    <asp:BoundField DataField="MaPhong" HeaderText="Mã phòng" SortExpression="MaPhong" ItemStyle-Width="80px" />
                    
                    <asp:CommandField ShowEditButton="True" HeaderText=" " ButtonType="Button" EditText="Edit" UpdateText="Update" CancelText="Cancel" />
                    
                    <asp:CommandField ShowDeleteButton="True" HeaderText=" " ButtonType="Button" DeleteText="Delete" />
                </Columns>
            </asp:GridView>

            <div class="link-quay-lai">
                <a href="Default.aspx">Quay lại</a>
            </div>
        </div>
    </form>
</body>
</html>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lab_CSDL
{
    public partial class qlPhongBan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Trong trường hợp này, AutoPostBack="True" trên ddlPhongBan đã tự động 
            // kích hoạt SqlDataSource lọc và GridView tự động Bind, 
            // nên không cần code đặc biệt trong Page_Load.
        }

        // Xử lý sự kiện khi nhấn nút 'Delete' trong GridView
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Bắt buộc đặt e.Cancel = true để ngăn GridView tự động xử lý. 
            // Ta sẽ tự gọi lệnh Delete của SqlDataSource.
            e.Cancel = true;

            // Lấy MaNV (Khóa chính) của dòng đang bị xóa từ DataKeyNames
            int maNV = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            // Gán giá trị MaNV vào tham số DeleteParameters của SqlDataSource
            DataNhanVienTheoPhong.DeleteParameters["MaNV"].DefaultValue = maNV.ToString();

            try
            {
                // Gọi phương thức Delete() trên SqlDataSource
                int rowsAffected = DataNhanVienTheoPhong.Delete();

                if (rowsAffected > 0)
                {
                    // Xóa thành công, nạp lại dữ liệu để GridView hiển thị danh sách mới
                    GridView1.DataBind();
                    // Có thể thêm thông báo "Xóa thành công" ở đây
                }
                else
                {
                    // Xóa không thành công (trường hợp hiếm, trừ khi có lỗi CSDL không báo)
                    Response.Write("<div style='color: orange; font-weight: bold; padding: 10px;'>Lỗi: Không tìm thấy nhân viên để xóa.</div>");
                }
            }
            catch (Exception ex)
            {
                // Xử lý lỗi CSDL (ví dụ: Ràng buộc khóa ngoại, không thể xóa)
                // Hiển thị thông báo lỗi ngay trên trang
                Response.Write("<div style='color: red; font-weight: bold; padding: 10px;'>Lỗi xóa dữ liệu: " + Server.HtmlEncode(ex.Message) + "</div>");
            }
        }
    }
}
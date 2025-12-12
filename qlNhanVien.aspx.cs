using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data; // Cần thiết cho các thao tác CSDL

namespace lab_CSDL
{
    public partial class qlNhanVien : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GridView1.DataBind();
            }
        }

        // Sự kiện xảy ra khi nhấn nút 'Edit'
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GridView1.DataBind();
        }

        // Sự kiện xảy ra khi nhấn nút 'Cancel' trong Edit mode
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GridView1.DataBind();
        }

        // Sự kiện xảy ra khi nhấn nút 'Update' trong Edit mode
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Bước 1: Ngăn GridView tự động xử lý (để ta tự gọi DataqlNhanVien.Update())
            e.Cancel = true;

            // Bước 2: Thiết lập tham số khóa chính cho SqlDataSource
            // Giá trị khóa chính (MaNV) luôn nằm trong OldValues.
            DataqlNhanVien.UpdateParameters["MaNV"].DefaultValue = GridView1.DataKeys[e.RowIndex].Value.ToString();

            // Bước 3: Thiết lập các giá trị mới từ GridView vào UpdateParameters
            // Lặp qua các BoundField để lấy giá trị mới.
            // Do ta dùng BoundField và CheckBoxField, các giá trị được tự động thu thập trong e.NewValues.
            // Tuy nhiên, vì ta đã đặt e.Cancel = true, ta cần lấy các giá trị từ e.NewValues và đặt vào UpdateParameters:

            // Lấy giá trị mới từ GridView và đưa vào SqlDataSource
            DataqlNhanVien.UpdateParameters["HoNV"].DefaultValue = e.NewValues["HoNV"].ToString();
            DataqlNhanVien.UpdateParameters["TenNV"].DefaultValue = e.NewValues["TenNV"].ToString();

            // Xử lý CheckBoxField (Phai). Giá trị thường là "on" hoặc "off" trong Web Forms hoặc Boolean
            if (e.NewValues["Phai"] != null)
            {
                DataqlNhanVien.UpdateParameters["Phai"].DefaultValue = e.NewValues["Phai"].ToString();
            }

            DataqlNhanVien.UpdateParameters["NgaySinh"].DefaultValue = e.NewValues["NgaySinh"].ToString();
            DataqlNhanVien.UpdateParameters["NoiSinh"].DefaultValue = e.NewValues["NoiSinh"].ToString();
            DataqlNhanVien.UpdateParameters["MaPhong"].DefaultValue = e.NewValues["MaPhong"].ToString();

            try
            {
                int rowsAffected = DataqlNhanVien.Update();
                if (rowsAffected > 0)
                {
                    // Thoát khỏi Edit mode
                    GridView1.EditIndex = -1;
                    // Nạp lại dữ liệu để cập nhật hiển thị
                    GridView1.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Xử lý lỗi CSDL (ví dụ: định dạng ngày tháng sai, ràng buộc khóa ngoại)
                Response.Write("<div style='color: red; font-weight: bold; padding: 10px;'>Lỗi cập nhật: " + Server.HtmlEncode(ex.Message) + "</div>");
                // Giữ lại Edit mode nếu muốn người dùng sửa lỗi
                e.Cancel = false;
            }
        }

        // Sự kiện xảy ra khi nhấn nút 'Delete'
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Bước 1: Ngăn GridView tự động xử lý (để ta tự gọi Delete())
            e.Cancel = true;

            // Bước 2: Lấy MaNV từ DataKeys (Đây là khóa chính để xóa)
            int maNV = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            // Bước 3: Thiết lập tham số khóa chính cho SqlDataSource
            DataqlNhanVien.DeleteParameters["MaNV"].DefaultValue = maNV.ToString();

            try
            {
                // Bước 4: Gọi lệnh Delete của SqlDataSource
                int rowsAffected = DataqlNhanVien.Delete();

                if (rowsAffected > 0)
                {
                    // Bước 5: Nạp lại dữ liệu để GridView hiển thị danh sách mới
                    GridView1.DataBind();
                    // Có thể thêm mã thông báo "Xóa thành công" ở đây
                }
            }
            catch (Exception ex)
            {
                // Bước 6: Xử lý lỗi CSDL (ví dụ: ràng buộc khóa ngoại)
                Response.Write("<div style='color: red; font-weight: bold; padding: 10px;'>Lỗi xóa: " + Server.HtmlEncode(ex.Message) + "</div>");
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Không xử lý gì ở đây nếu không dùng
        }
    }
}
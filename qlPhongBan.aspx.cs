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

        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            e.Cancel = true;

            int maNV = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            DataNhanVienTheoPhong.DeleteParameters["MaNV"].DefaultValue = maNV.ToString();

            try
            {
                int rowsAffected = DataNhanVienTheoPhong.Delete();

                if (rowsAffected > 0)
                {
                    GridView1.DataBind();
                }
                else
                {
                    Response.Write("<div style='color: orange; font-weight: bold; padding: 10px;'>Lỗi: Không tìm thấy nhân viên để xóa.</div>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<div style='color: red; font-weight: bold; padding: 10px;'>Lỗi xóa dữ liệu: " + Server.HtmlEncode(ex.Message) + "</div>");
            }
        }
    }
}
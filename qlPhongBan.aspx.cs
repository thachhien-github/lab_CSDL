using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lab_CSDL
{
    public partial class qlPhongBan : Page
    {
        protected void dgvNhanVien_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                e.Cancel = true;

                string maNV = dgvNhanVien.DataKeys[e.RowIndex].Value.ToString();
                DataNhanVienTheoPhong.DeleteParameters["MaNV"].DefaultValue = maNV;

                int rows = DataNhanVienTheoPhong.Delete();

                if (rows > 0)
                {
                    dgvNhanVien.DataBind();
                    ShowMessage("✔ Đã xóa nhân viên!", true);
                }
                else
                {
                    ShowMessage("❌ Không tìm thấy nhân viên để xóa!", false);
                }
            }
            catch
            {
                ShowMessage("❌ Không thể xóa nhân viên do ràng buộc dữ liệu!", false);
            }
        }

        protected void dgvNhanVien_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                foreach (Control c in e.Row.Cells[e.Row.Cells.Count - 1].Controls)
                {
                    if (c is LinkButton btn && btn.CommandName == "Delete")
                    {
                        btn.OnClientClick = "return ConfirmDelete();";
                    }
                }
            }
        }



        void ShowMessage(string msg, bool success)
        {
            lblMessage.Text = msg;
            lblMessage.CssClass = success ? "message success" : "message error";
            lblMessage.Visible = true;
        }
    }
}

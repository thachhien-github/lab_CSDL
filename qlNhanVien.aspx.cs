using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lab_CSDL
{
    public partial class qlNhanVien : Page
    {

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(txtHoNV.Text)
                    || string.IsNullOrWhiteSpace(txtTenNV.Text)
                    || string.IsNullOrWhiteSpace(txtNgaySinh.Text)
                    || string.IsNullOrWhiteSpace(txtNoiSinh.Text)
                    || string.IsNullOrEmpty(ddlMaPhong.SelectedValue))
                {
                    ShowMessage("❌ Vui lòng nhập đầy đủ thông tin!", false);
                    return;
                }

                DateTime ns = DateTime.Parse(txtNgaySinh.Text);
                if (ns >= DateTime.Today)
                {
                    ShowMessage("❌ Ngày sinh phải nhỏ hơn ngày hiện tại!", false);
                    return;
                }

                DataqlNhanVien.InsertParameters["HoNV"].DefaultValue = txtHoNV.Text;
                DataqlNhanVien.InsertParameters["TenNV"].DefaultValue = txtTenNV.Text;
                DataqlNhanVien.InsertParameters["Phai"].DefaultValue = chkPhai.Checked.ToString();
                DataqlNhanVien.InsertParameters["NgaySinh"].DefaultValue = txtNgaySinh.Text;
                DataqlNhanVien.InsertParameters["NoiSinh"].DefaultValue = txtNoiSinh.Text;
                DataqlNhanVien.InsertParameters["MaPhong"].DefaultValue = ddlMaPhong.SelectedValue;

                DataqlNhanVien.Insert();
                dgvNhanVien.DataBind();

                ShowMessage("✔ Thêm nhân viên thành công!", true);
                ClearForm();
            }
            catch (SqlException)
            {
                ShowMessage("❌ Lỗi dữ liệu SQL!", false);
            }
        }

        private void ClearForm()
        {
            txtHoNV.Text = string.Empty;
            txtTenNV.Text = string.Empty;
            txtNgaySinh.Text = string.Empty;
            txtNoiSinh.Text = string.Empty;

            chkPhai.Checked = false;

            if (ddlMaPhong.Items.Count > 0)
                ddlMaPhong.SelectedIndex = 0;

            lblMessage.Visible = false;
        }

        protected void dgvNhanVien_RowEditing(object sender, GridViewEditEventArgs e)
        {
            dgvNhanVien.EditIndex = e.NewEditIndex;
            dgvNhanVien.DataBind();
        }

        protected void dgvNhanVien_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            dgvNhanVien.EditIndex = -1;
            dgvNhanVien.DataBind();
        }

        protected void dgvNhanVien_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = dgvNhanVien.Rows[e.RowIndex];
                DateTime ns = DateTime.Parse(((TextBox)row.Cells[4].Controls[0]).Text);

                if (ns >= DateTime.Today)
                {
                    ShowMessage("❌ Ngày sinh không hợp lệ!", false);
                    return;
                }

                CheckBox chk = (CheckBox)row.FindControl("chkEditPhai");
                DropDownList ddl = (DropDownList)row.FindControl("ddlEditPhong");

                DataqlNhanVien.UpdateParameters["Phai"].DefaultValue = chk.Checked.ToString();
                DataqlNhanVien.UpdateParameters["MaPhong"].DefaultValue = ddl.SelectedValue;

                DataqlNhanVien.Update();
                dgvNhanVien.EditIndex = -1;
                dgvNhanVien.DataBind();

                ShowMessage("✔ Cập nhật thành công!", true);
            }
            catch
            {
                ShowMessage("❌ Lỗi cập nhật dữ liệu!", false);
            }
        }

        protected void dgvNhanVien_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            DataqlNhanVien.DeleteParameters["MaNV"].DefaultValue =
                dgvNhanVien.DataKeys[e.RowIndex].Value.ToString();
            DataqlNhanVien.Delete();
            dgvNhanVien.DataBind();

            ShowMessage("✔ Đã xóa nhân viên!", true);
        }

        protected void dgvNhanVien_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && dgvNhanVien.EditIndex == -1)
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

        protected void dgvNhanVien_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvNhanVien.PageIndex = e.NewPageIndex;
            dgvNhanVien.EditIndex = -1; // thoát chế độ sửa nếu đang edit
            dgvNhanVien.DataBind();
        }

    }
}

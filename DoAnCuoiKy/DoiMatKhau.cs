﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DoAnCuoiKy
{
    public partial class DoiMatKhau : Form
    {
        public DoiMatKhau instance;
        public DoiMatKhau()
        {
            instance = this;
            InitializeComponent();
        }

        private void DoiMatKhau_Load(object sender, EventArgs e)
        {
            //Load các tài khoản hiện có lên listbox để admin có quyền thay đổi;
            //listBox_AllAccount.DataSource;
        }

        private void btn_ThoatDangNhap_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}

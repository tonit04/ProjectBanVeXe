﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyLibrary.DTO
{
    [Table("UserAccount")]
    public class Account
    {
        private int _userID;
        private string _name;
        private string userName;
        private string password;
        private string cccd;
        [Column("UserID")]
        public int UserID { get => _userID; set => _userID = value; }
        [Column("FullName")]
        public string Name { get => _name; set => _name = value; }
        [Column("Email")]
        public string UserName { get => userName; set => userName = value; }
        [Column("Password")]
        public string Password { get => password; set => password = value; }
        [Column("CCCD")]

        public string CCCD { get => cccd; set => cccd = value; }
        public Account() { }

        public Account(string username, string password) {
            this.UserName = username;
            this.Password = password;
        }
    }
}

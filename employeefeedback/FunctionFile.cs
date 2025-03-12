using Newtonsoft.Json;
using Org.BouncyCastle.Asn1.Ocsp;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace employeefeedback
{
    public class FunctionFile
    {
        public static void PreviousEmployee(HttpResponse Response, HttpSessionState Session)
        {
            string sessionRole = Session["Role"]?.ToString();
            int roleId = GetRoleIdByName(sessionRole);

            if (roleId == 1)
            {
                Response.Redirect("PreviousEmployeeList.aspx");
            }
            else
            {
                Response.Write("<script>alert('Access Denied! Only administrators are allowed to perform this action.'); window.location='EmployeeDashboard.aspx';</script>");
                Response.End();

            }
        }

        public static void CurrentEmployee(HttpResponse Response, HttpSessionState Session)
        {
            string sessionRole = Session["Role"]?.ToString();
            int roleId = GetRoleIdByName(sessionRole);

            if (roleId == 1)
            { 
                Response.Redirect("EmployeeList.aspx");
            }
            else
            {
                Response.Write("<script>alert('Access Denied! Only administrators are allowed to perform this action.'); window.location='EmployeeDashboard.aspx';</script>");
                Response.End();

            }
        }

        public static void Home(HttpResponse Response, HttpSessionState Session)
        {
            string sessionRole = Session["Role"]?.ToString(); 
            int roleId = GetRoleIdByName(sessionRole);

            if (roleId == 1)
            {
                Response.Redirect("Dashboard.aspx");
            }
            else
            {
                Response.Redirect("EmployeeDashboard.aspx");
            }
        }

        public static void About(HttpResponse Response)
        {
            Response.Redirect("About.aspx");
        }

        public static void Logout(HttpResponse Response, HttpSessionState Session, HttpRequest Request)
        {
            Session.Abandon();
            if (Request.Cookies[".ASPXAUTH"] != null)
            {
                var cookie = new HttpCookie(".ASPXAUTH");
                cookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookie);
            }
            Response.Redirect("Default.aspx");
        }

        public static void PageLoad(HttpResponse Response, HttpSessionState Session)
        {
            Response.Cache.SetExpires(DateTime.Now.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetValidUntilExpires(false);

            // If the user is not logged in, redirect to login page
            if (Session["UserName"] == null && Session["Role"] == null && Session["EmployeeID"] == null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        public static string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder sb = new StringBuilder();
                foreach (byte b in bytes)
                {
                    sb.Append(b.ToString("x2"));
                }
                return sb.ToString();
            }
        }

        public static string GetRoleNameById(int roleId)
        {
            try
            {
                // Path to the roles.json file (stored in the App_Data folder)
                string jsonFilePath = HttpContext.Current.Server.MapPath("roles.json");
                string jsonData = File.ReadAllText(jsonFilePath);  // Read the file content

                // Deserialize the JSON data into a list of Role objects
                List<Role> roles = JsonConvert.DeserializeObject<List<Role>>(jsonData);


                Role role = roles.Find(r => r.RoleId == roleId);

                // Return RoleName if found, else return "Unknown"
                return role?.RoleName ?? "Unknown";
            }
            catch (Exception ex)
            {
                // Log the error (you can replace this with proper logging)
                Console.WriteLine($"Error loading roles: {ex.Message}");
                return "Unknown";
            }
        }

        public static int GetRoleIdByName(string roleName)
        {
            try
            {
      
                string jsonFilePath = HttpContext.Current.Server.MapPath("roles.json");
                string jsonData = File.ReadAllText(jsonFilePath);  // Read the file content

              
                List<Role> roles = JsonConvert.DeserializeObject<List<Role>>(jsonData);

             
                Role role = roles.Find(r => r.RoleName.Equals(roleName, StringComparison.OrdinalIgnoreCase));

             
                return role?.RoleId ?? -1;
            }
            catch (Exception ex)
            {
              
                Console.WriteLine($"Error loading roles: {ex.Message}");
                return -1;
            }
        }

    }

}

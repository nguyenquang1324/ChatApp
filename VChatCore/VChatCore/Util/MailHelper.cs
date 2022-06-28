using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace VChatCore.Util
{
    public class MailHelper
    {
        public static void SendMail(string subject, string body, List<string> to, List<string> cc = null, List<string> bcc = null, List<Attachment> attachments = null)
        {
            SmtpClient client = new SmtpClient("smtp.gmail.com");

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("quangnguyenyolo@gmail.com", "System Notification", Encoding.UTF8);
            mail.Subject = subject;
            mail.Body = body;
            mail.IsBodyHtml = true;

            if (to != null && to.Count > 0)
            {
                foreach (string email in to)
                {
                    if (!string.IsNullOrWhiteSpace(email))
                        mail.To.Add(new MailAddress(email.Trim()));
                }
            }

            if (cc != null && cc.Count > 0)
            {
                foreach (string email in cc)
                {
                    if (!string.IsNullOrWhiteSpace(email))
                        mail.CC.Add(new MailAddress(email.Trim()));
                }
            }

            if (bcc != null && bcc.Count > 0)
            {
                foreach (string email in bcc)
                {
                    if (!string.IsNullOrWhiteSpace(email))
                        mail.Bcc.Add(new MailAddress(email.Trim()));
                }
            }

            if (attachments != null && attachments.Count > 0)
            {
                foreach (var attachment in attachments)
                {
                    mail.Attachments.Add(attachment);
                }
            }

            client.Port = 587;
            client.Credentials = new System.Net.NetworkCredential("quangnguyenyolo@gmail.com", "ydibmywkqcahacyg");
            client.EnableSsl = true;
            client.Send(mail);
        }

    }
}

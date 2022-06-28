using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.SignalR;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using VChatCore.Dto;
using VChatCore.Model;
using VChatCore.Util;

namespace VChatCore.Service
{
    public class UserService
    {
        protected readonly MyContext context;
        protected IHubContext<ChatHub> chatHub;
        protected readonly IWebHostEnvironment hostEnvironment;

        public UserService(MyContext context, IHubContext<ChatHub> chatHub, IWebHostEnvironment hostEnvironment)
        {
            this.context = context;
            this.chatHub = chatHub;
            this.hostEnvironment = hostEnvironment;
        }

        /// <summary>
        /// Lấy thông tin cá nhân của user
        /// </summary>
        /// <param name="userCode">User hiện tại đang đăng nhập</param>
        /// <returns>Thông tin user</returns>
        public UserDto GetProfile(string userCode)
        {
            return this.context.Users
                    .Where(x => x.Code.Equals(userCode))
                    .Select(x => new UserDto()
                    {
                        Code = x.Code,
                        FullName = x.FullName,
                        Address = x.Address,
                        Avatar = x.Avatar,
                        Email = x.Email,
                        Gender = x.Gender,
                        Phone = x.Phone,
                        Dob = x.Dob
                    }).FirstOrDefault();
        }

        /// <summary>
        /// Cập nhật thông tin cá nhân
        /// </summary>
        /// <param name="userCode">User hiện tại đang đăng nhập</param>
        /// <param name="user">Thông tin user</param>
        /// <returns></returns>
        public UserDto UpdateProfile(string userCode, UserDto user)
        {
            User us = this.context.Users
                    .FirstOrDefault(x => x.Code.Equals(userCode));

            if (us != null)
            {
                us.FullName = user.FullName;
                us.Dob = user.Dob;
                us.Email = user.Email;

                if (user.Avatar.Contains("data:image/png;base64,"))
                {
                    string pathAvatar = $"Resource/Avatar/{Guid.NewGuid().ToString("N")}";
                    string pathFile = Path.Combine(this.hostEnvironment.ContentRootPath, pathAvatar);
                    DataHelper.Base64ToImage(user.Avatar.Replace("data:image/png;base64,", ""), pathFile);
                    us.Avatar = user.Avatar = pathAvatar;
                }

                us.Address = user.Address;
                us.Phone = user.Phone;
                us.Gender = user.Gender;

                this.context.SaveChanges();
            }
            return user;
        }

        /// <summary>
        /// Lấy danh sách liên hệ của user
        /// </summary>
        /// <param name="userCode">User hiện tại đang đăng nhập</param>
        /// <returns>Danh sách liên hệ</returns>
        public List<UserDto> GetContact(string userCode)
        {
            List<UserDto> contacts = this.context.Contacts
                     .Where(x => x.ContactCode.Equals(userCode))
                     .OrderBy(x => x.UserContact.FullName)
                     .Select(x => new UserDto()
                     {
                         Avatar = x.User.Avatar,
                         Code = x.User.Code,
                         FullName = x.User.FullName,
                         Address = x.User.Address,
                         Dob = x.User.Dob,
                         Email = x.User.Email,
                         Gender = x.User.Gender,
                         Phone = x.User.Phone,
                         Approved = x.Approved,
                         FieldStamp = x.ContactCode
                     })
                     .ToList();

            List<UserDto> friends = this.context.Contacts
                     .Where(x => x.UserCode.Equals(userCode))
                     .OrderBy(x => x.UserContact.FullName)
                     .Select(x => new UserDto()
                     {
                         Avatar = x.UserContact.Avatar,
                         Code = x.UserContact.Code,
                         FullName = x.UserContact.FullName,
                         Address = x.UserContact.Address,
                         Dob = x.UserContact.Dob,
                         Email = x.UserContact.Email,
                         Gender = x.UserContact.Gender,
                         Phone = x.UserContact.Phone,
                         Approved = x.Approved,
                         FieldStamp2 = x.UserCode
                     })
                     .ToList();

            contacts.AddRange(friends);
            return contacts.FindAll(x => x.Code != userCode);
        }

        /// <summary>
        /// Tìm kiếm liên hệ.
        /// </summary>
        /// <param name="userCode">User hiện tại đang đăng nhập</param>
        /// <param name="keySearch">Từ khóa tìm kiếm</param>
        /// <returns></returns>
        public List<UserDto> SearchContact(string userCode, string keySearch)
        {
            if (string.IsNullOrWhiteSpace(keySearch))
                return new List<UserDto>();

            List<ContactDto> friends = context.Contacts
                   .Where(x => x.UserCode.Equals(userCode) || x.ContactCode.Equals(userCode))
                   .Select(x => new ContactDto()
                   {
                       ContactCode = x.ContactCode,
                       UserCode = x.UserCode
                   }).ToList();

            List<UserDto> users = context.Users
                .Where(x => !x.Code.Equals(userCode))
                .Where(x => x.FullName.Contains(keySearch) || x.Phone.Contains(keySearch) || x.Email.Contains(keySearch))
                .OrderBy(x => x.FullName)
                .Select(x => new UserDto()
                {
                    Avatar = x.Avatar,
                    Code = x.Code,
                    FullName = x.FullName,
                }).ToList();

            users.ForEach(x =>
            {
                if (friends.Any(y => y.UserCode.Equals(x.Code) || y.ContactCode.Equals(x.Code)))
                    x.IsFriend = true;
            });

            // Loại bỏ liên hệ đã có
            return users.FindAll(x => !x.IsFriend);
        }

        /// <summary>
        /// Thêm mới liên hệ
        /// </summary>
        /// <param name="userCode">User hiện tại đang đăng nhập</param>
        /// <param name="user">Thông tin liên hệ</param>
        public void AddContact(string userCode, UserDto user)
        {
            User us = this.context.Users
                .FirstOrDefault(x => x.Code == userCode);
            Contact contact = new Contact()
            {
                UserCode = userCode,
                ContactCode = user.Code,
                Created = DateTime.Now,
                Approved = false
            };
            context.Contacts.Add(contact);

            context.SaveChanges();

            try
            {
                this.chatHub.Clients.All.SendAsync(user.Code + "_add_contact", new
                {
                    name = us.FullName,
                });
            }
            catch { }
        }

        /// <summary>
        /// Approve liên hệ
        /// </summary>
        /// <param name="userCode"></param>
        /// <param name="contactCode"></param>
        /// <returns></returns>
        public UserDto Approve(string userCode, string contactCode)
        {
            Contact contact = this.context.Contacts
                .Where(x => x.UserCode == contactCode && x.ContactCode == userCode)
                .Where(x => !x.Approved)
                .FirstOrDefault();

            if (contact != null)
            {
                contact.Approved = true;
                this.context.SaveChanges();

                UserDto user = new UserDto()
                {
                    Avatar = contact.UserContact.Avatar,
                    Code = contact.UserContact.Code,
                    FullName = contact.UserContact.FullName,
                    Address = contact.UserContact.Address,
                    Dob = contact.UserContact.Dob,
                    Email = contact.UserContact.Email,
                    Gender = contact.UserContact.Gender,
                    Phone = contact.UserContact.Phone,
                    Approved = contact.Approved
                };

                try
                {
                    User us = this.context.Users
                        .FirstOrDefault(x => x.Code == userCode);

                    this.chatHub.Clients.All.SendAsync(contact.UserCode + "_approve_contact", new
                    {
                        name = us.FullName,
                        contact = user
                    });
                    this.chatHub.Clients.All.SendAsync(userCode + "_refresh_contact");
                }
                catch { }
                return user;
            }
            return null;
        }

        /// <summary>
        /// Reject liên hệ
        /// </summary>
        /// <param name="userCode"></param>
        /// <param name="contactCode"></param>
        /// <returns></returns>
        public UserDto Reject(string userCode, string contactCode)
        {
            Contact contact = this.context.Contacts
                .Where(x => x.UserCode == contactCode && x.ContactCode == userCode)
                .Where(x => !x.Approved)
                .FirstOrDefault();

            if (contact != null)
            {
                UserDto user = new UserDto()
                {
                    Avatar = contact.UserContact.Avatar,
                    Code = contact.UserContact.Code,
                    FullName = contact.UserContact.FullName,
                    Address = contact.UserContact.Address,
                    Dob = contact.UserContact.Dob,
                    Email = contact.UserContact.Email,
                    Gender = contact.UserContact.Gender,
                    Phone = contact.UserContact.Phone,
                    Approved = contact.Approved
                };
                this.context.Contacts.Remove(contact);
                this.context.SaveChanges();

                try
                {
                    User us = this.context.Users
                        .FirstOrDefault(x => x.Code == userCode);

                    this.chatHub.Clients.All.SendAsync(contact.UserCode + "_reject_contact", new
                    {
                        name = us.FullName,
                        contact = user
                    });
                    this.chatHub.Clients.All.SendAsync(userCode + "_refresh_contact");
                }
                catch { }
                return user;
            }
            return null;
        }
    }
}

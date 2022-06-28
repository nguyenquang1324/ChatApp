import { Component, Input, OnInit, SimpleChanges } from '@angular/core';
import { AuthenticationService } from 'src/app/core/service/authentication.service';
import { CallService } from 'src/app/core/service/call.service';
import { UserService } from 'src/app/core/service/user.service';
declare const $: any;

@Component({
  selector: 'app-contact-detail',
  templateUrl: './contact-detail.component.html',
  styleUrls: ['./contact-detail.component.css']
})
export class ContactDetailComponent implements OnInit {
  @Input() contact!: any;

  toggleTabChat: boolean = false;
  currentUser: any = {};
  constructor(
    private authenticationService: AuthenticationService,
    private callService: CallService,
    private userService: UserService
  ) { }

  ngOnInit() {
    this.currentUser = this.authenticationService.currentUserValue;
  }

  ngOnChanges(changes: SimpleChanges): void {
    if ("contact" in changes) {
      this.toggleTabChat = false;
    }
  }

  chat() {
    this.toggleTabChat = true;
  }

  callVideo() {
    this.callService.call(this.contact.Code)
      .subscribe((resp: any) => {
        let data = JSON.parse(resp["data"]);
        $("#outgoingCallIframe").attr("src", data);
        $("#modalOutgoingCall").modal();
        console.log('callVideo', data)
      }, (error) => {
        console.log(error)
      });
  }

  approve() {
    this.userService.approve(this.contact.Code)
      .subscribe((resp: any) => {
        this.contact.Approved = true;
      }, (error) => {
        console.log(error)
      });
  }

  reject() {
    this.userService.reject(this.contact.Code)
      .subscribe((resp: any) => {
        this.contact.Approved = null;
      }, (error) => {
        console.log(error)
      });
  }
}

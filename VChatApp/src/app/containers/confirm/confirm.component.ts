import { Component, NgZone, OnInit } from '@angular/core';
import { UntypedFormGroup, UntypedFormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { NgxSpinnerService } from 'ngx-spinner';
import { ToastrService } from 'ngx-toastr';
import { finalize } from 'rxjs/operators';
import { AuthenticationService } from 'src/app/core/service/authentication.service';

@Component({
  selector: 'app-confirm',
  templateUrl: './confirm.component.html',
  styleUrls: ['./confirm.component.css']
})
export class ConfirmComponent implements OnInit {
  formData!: UntypedFormGroup;
  submitted: boolean = false;

  userCode = "";
  tokenCode = "";

  constructor(
    private authenticationService: AuthenticationService,
    private formBuilder: UntypedFormBuilder,
    private activatedRoute: ActivatedRoute,
    private ngZone: NgZone,
    private router: Router,
    private spinner: NgxSpinnerService,
    private toastr: ToastrService
  ) {
  }

  ngOnInit() {
    this.formData = this.formBuilder.group({
      otpCode: ["", Validators.required],
    });

    this.activatedRoute.queryParams.subscribe(params => {
      this.userCode = params.userCode;
      this.tokenCode = params.tokenCode;
    });
  }

  onSubmit() {
    this.submitted = true;
    if (this.formData.invalid) {
      return;
    }

    this.spinner.show();
    this.authenticationService
      .confirm(this.userCode, this.tokenCode, this.formData.getRawValue().otpCode)
      .pipe(
        finalize(() => {
          this.spinner.hide();
        })
      )
      .subscribe(
        (data) => {
          this.toastr.success("Xác thực thành công")
          this.navigate("/")
        },
        (error) => {
          this.toastr.error(error.error.message);
        }
      );
  }

  navigate(path: string): void {
    this.ngZone.run(() => this.router.navigateByUrl(path)).then();
  }

}

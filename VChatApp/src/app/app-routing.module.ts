import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AuthGuardService } from './auth/auth-guard.service';
import { ConfirmComponent } from './containers/confirm/confirm.component';
import { HomeComponent } from './containers/home/home.component';
import { LoginComponent } from './containers/login/login.component';
import { LogoutComponent } from './containers/logout/logout.component';
import { PageNotFoundComponent } from './containers/page-not-found/page-not-found.component';
import { SignUpComponent } from './containers/sign-up/sign-up.component';


const routes: Routes = [
  {
    path: "dang-nhap",
    component: LoginComponent
  },
  {
    path: "dang-xuat",
    component: LogoutComponent
  },
  {
    path: "dang-ky-tai-khoan",
    component: SignUpComponent
  },
  {
    path: "xac-thuc",
    component: ConfirmComponent
  },
  {
    path: "",
    component: HomeComponent,
    canActivate: [AuthGuardService],
  },
  {
    path: "**",
    component: PageNotFoundComponent
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

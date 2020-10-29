
import 'package:orim/repositories/area/area_imp_repo.dart';
import 'package:orim/repositories/area/area_repo.dart';
import 'package:orim/repositories/auth/auth_imp.dart';
import 'package:orim/repositories/auth/auth_repo.dart';
import 'package:orim/repositories/catergories/categories_imp.dart';
import 'package:orim/repositories/catergories/categories_repo.dart';
import 'package:orim/repositories/change_pass/change_pass_imp.dart';
import 'package:orim/repositories/change_pass/change_pass_repo.dart';
import 'package:orim/repositories/dashboard/dashboard_imp.dart';
import 'package:orim/repositories/dashboard/dashboard_repo.dart';
import 'package:orim/repositories/department/department_repo.dart';
import 'package:orim/repositories/department/department_repo_imp.dart';
import 'package:orim/repositories/feedback/send_feedback_imp.dart';
import 'package:orim/repositories/feedback/send_feedback_repo.dart';
import 'package:orim/repositories/info_personal/info_personal_imp.dart';
import 'package:orim/repositories/info_personal/info_personal_repo.dart';
import 'package:orim/repositories/issue/issue_imp.dart';
import 'package:orim/repositories/issue/issue_repo.dart';
import 'package:orim/repositories/issue_administration/issue_administration_imp.dart';
import 'package:orim/repositories/issue_administration/issue_administration_repo.dart';
import 'package:orim/repositories/issue_approve/issue_approve_imp.dart';
import 'package:orim/repositories/issue_approve/issue_approve_repo.dart';
import 'package:orim/repositories/issue_need_assign/issue_need_assign_imp.dart';
import 'package:orim/repositories/issue_need_assign/issue_need_assign_repo.dart';
import 'package:orim/repositories/issue_process/issue_process_imp.dart';
import 'package:orim/repositories/issue_process/issue_process_repo.dart';
import 'package:orim/repositories/issues_area/issues_area_imp.dart';
import 'package:orim/repositories/issues_area/issues_area_repo.dart';
import 'package:orim/repositories/marker/marker_imp.dart';
import 'package:orim/repositories/marker/marker_repo.dart';
import 'package:orim/repositories/notification/Notification_imp.dart';
import 'package:orim/repositories/notification/Notification_repo.dart';
import 'package:orim/repositories/officer/officer_imp.dart';
import 'package:orim/repositories/officer/officer_repo.dart';
import 'package:orim/repositories/permission/permission_imp.dart';
import 'package:orim/repositories/permission/permission_repo.dart';
import 'package:orim/repositories/province/province_imp.dart';
import 'package:orim/repositories/province/province_repo.dart';
import 'package:orim/repositories/splash/splash.dart';
import 'package:orim/repositories/splash/splash_imp.dart';
import 'package:orim/repositories/userinfo/user_info_imp.dart';
import 'package:orim/repositories/userinfo/user_info_repo.dart';
import 'package:orim/repositories/ward/ward_imp.dart';
import 'package:orim/repositories/ward/ward_repo.dart';
import 'package:orim/storage/area/remote/AreaRemote.dart';
import 'package:orim/storage/area/remote/AreaRemoteImp.dart';
import 'package:orim/storage/auth/local/auth_local.dart';
import 'package:orim/storage/auth/local/auth_local_imp.dart';
import 'package:orim/storage/auth/remote/auth_remote.dart';
import 'package:orim/storage/auth/remote/auth_remote_imp.dart';
import 'package:orim/storage/dashboard/remote/dashboard_remote.dart';
import 'package:orim/storage/dashboard/remote/dashboard_remote_imp.dart';
import 'package:orim/storage/department/local/department_local.dart';
import 'package:orim/storage/department/local/department_local_imp.dart';
import 'package:orim/storage/department/remote/department_remote.dart';
import 'package:orim/storage/department/remote/department_remote_imp.dart';
import 'package:orim/storage/info_personal/local/info_personal_local.dart';
import 'package:orim/storage/info_personal/local/info_personal_local_imp.dart';
import 'package:orim/storage/issue/local/issue_local.dart';
import 'package:orim/storage/issue/local/issue_local_imp.dart';
import 'package:orim/storage/issue/remote/issue_remote.dart';
import 'package:orim/storage/issue/remote/issue_remote_imp.dart';
import 'package:orim/storage/marker/remote/marker_remote.dart';
import 'package:orim/storage/marker/remote/marker_remote_imp.dart';
import 'package:orim/storage/notification/local/notification_local.dart';
import 'package:orim/storage/notification/local/notification_local_imp.dart';
import 'package:orim/storage/officer/remote/officer_remote.dart';
import 'package:orim/storage/officer/remote/officer_remote_imp.dart';
import 'package:orim/storage/permission/local/permission_local.dart';
import 'package:orim/storage/permission/local/permission_local_imp.dart';
import 'package:orim/storage/permission/remote/permission_remote.dart';
import 'package:orim/storage/permission/remote/permission_remote_imp.dart';
import 'package:orim/storage/user_info/local/user_info_local.dart';
import 'package:orim/storage/user_info/local/user_info_local_imp.dart';
import 'package:orim/storage/user_info/remote/change_password/change_pass_imp.dart';
import 'package:orim/storage/user_info/remote/change_password/change_pass_remote.dart';
import 'package:orim/storage/user_info/remote/create_account/create_account_remote.dart';
import 'package:orim/storage/user_info/remote/create_account/create_account_remote_imp.dart';
import 'package:orim/storage/user_info/remote/user_remote.dart';
import 'package:orim/storage/user_info/remote/user_remote_imp.dart';
import 'package:orim/utils/api_service.dart';
import 'package:orim/utils/gallery_storage/gallery_storage.dart';
import 'package:orim/utils/storage/storage.dart';
import 'package:orim/utils/storage/storage_imp.dart';
import 'package:orim/utils/task_util.dart';
import 'package:orim/viewmodel/assign_execute.dart';
import 'package:orim/viewmodel/assign_support.dart';
import 'package:orim/viewmodel/auth.dart';
import 'package:orim/viewmodel/category.dart';
import 'package:orim/viewmodel/category_execute.dart';
import 'package:orim/viewmodel/change_pass.dart';
import 'package:orim/viewmodel/dashboard.dart';
import 'package:orim/viewmodel/department_assign_unit.dart';
import 'package:orim/viewmodel/department_support.dart';
import 'package:orim/viewmodel/handle_complain.dart';
import 'package:orim/viewmodel/helper.dart';
import 'package:orim/viewmodel/issue.dart';
import 'package:orim/viewmodel/issue_administration.dart';
import 'package:orim/viewmodel/issue_root_administration.dart';
import 'package:orim/viewmodel/issue_need_assign.dart';
import 'package:orim/viewmodel/issue_process.dart';
import 'package:orim/viewmodel/issues_area.dart';
import 'package:orim/viewmodel/location.dart';
import 'package:orim/viewmodel/marker.dart';
import 'package:orim/viewmodel/notification.dart';
import 'package:orim/viewmodel/officer.dart';
import 'package:orim/viewmodel/permission.dart';
import 'package:orim/viewmodel/province_info.dart';
import 'package:orim/viewmodel/report_spam.dart';
import 'package:orim/viewmodel/resident_info.dart';
import 'package:orim/viewmodel/send_feedback.dart';
import 'package:orim/viewmodel/send_info_approve.dart';
import 'package:orim/viewmodel/send_info_process.dart';
import 'package:orim/viewmodel/send_info_support.dart';
import 'package:orim/viewmodel/splash.dart';
import 'package:orim/viewmodel/user_info.dart';
import 'package:orim/viewmodel/user_info_personal.dart';
import 'package:orim/viewmodel/ward_info.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'observer/create_issue.dart';
import 'observer/delete_all_notification.dart';
import 'observer/force_logout.dart';

class ProviderApp {
  List<SingleChildWidget> generateProvider() {
    List<SingleChildWidget> list = [];
    list.addAll(generateStorageProvider());
    list.addAll(generateRepoProvider());
    list.addAll(generateViewModelProvider());
    return list;
  }

  List<SingleChildWidget> generateStorageProvider() {
    return [
      Provider<TaskUtil>(create: (_) => TaskUtil()),
      Provider<Storage>(create: (_) => StorageImp()),
      Provider<ForceLogoutObserver>(
        create: (_) => ForceLogoutObserver(),
      ),
      Provider<GalleryStorage>(create: (_) => GalleryStorage()),
      ProxyProvider<ForceLogoutObserver, ApiService>(
        create: (_) => ApiService(),
        update: (context, logout, previous) {
          if (previous is ApiService) {
            previous.logoutObserver = logout;
          }
          return previous;
        },
      ),
      ProxyProvider<Storage, UserInfoLocal>(
        create: (_) => UserInfoLocalImp(),
        update: (context, storage, previous) {
          if (previous is UserInfoLocalImp) {
            previous.storage = storage;
          }
          return previous;
        },
      ),
      ProxyProvider<Storage, AuthLocal>(
        create: (_) => AuthLocalImp(),
        update: (context, storage, previous) {
          if (previous is AuthLocalImp) {
            previous.storage = storage;
          }
          return previous;
        },
      ),
      ProxyProvider<ApiService, AuthRemote>(
        create: (_) => AuthRemoteImp(),
        update: (context, apiService, previous) {
          if (previous is AuthRemoteImp) {
            previous.apiService = apiService;
          }
          return previous;
        },
      ),
      ProxyProvider<Storage, IssueLocal>(
        create: (_) => IssueLocalImp(),
        update: (context, storage, previous) {
          if (previous is IssueLocalImp) {
            previous.storage = storage;
          }
          return previous;
        },
      ),
      ProxyProvider<ApiService, IssueRemote>(
        create: (_) => IssueRemoteImp(),
        update: (context, apiService, previous) {
          if (previous is IssueRemoteImp) {
            previous.apiService = apiService;
          }
          return previous;
        },
      ),
      ProxyProvider<ApiService, ChangePasswordRemote>(
        create: (_) => ChangePassRemoteImp(),
        update: (context, apiService, previous) {
          if (previous is ChangePassRemoteImp) {
            previous.apiService = apiService;
          }
          return previous;
        },
      ),
      ProxyProvider<ApiService, CreateAccountRemote>(
          create: (_) => CreateAccountRemoteImp(),
          update: (context, apiService, previous) {
            if (previous is CreateAccountRemoteImp) {
              previous.apiService = apiService;
            }
            return previous;
          }),
      ProxyProvider<Storage, PermissionLocal>(
        create: (_) => PermissionLocalImp(),
        update: (context, storage, previous) {
          if (previous is PermissionLocalImp) {
            previous.storage = storage;
          }
          return previous;
        },
      ),
      ProxyProvider<ApiService, PermissionRemote>(
        create: (_) => PermissionRemoteImp(),
        update: (context, apiService, previous) {
          if (previous is PermissionRemoteImp) {
            previous.apiService = apiService;
          }
          return previous;
        },
      ),
      ProxyProvider<ApiService, OfficerRemote>(
        create: (_) => OfficerRemoteImp(),
        update: (context, apiService, previous) {
          if (previous is OfficerRemoteImp) {
            previous.apiService = apiService;
          }
          return previous;
        },
      ),
      ProxyProvider<Storage, InfoPersonalLocal>(
        create: (_) => InfoPersonalLocalImp(),
        update: (context, storage, previous) {
          if (previous is InfoPersonalLocalImp) {
            previous.storage = storage;
          }
          return previous;
        },
      ),
      ProxyProvider<Storage, DepartmentLocal>(
        create: (_) => DepartmentLocalImp(),
        update: (
          context,
          storage,
          previous,
        ) {
          if (previous is DepartmentLocalImp) {
            previous.storage = storage;
          }
          return previous;
        },
      ),
      ProxyProvider<ApiService, DepartmentRemote>(
        create: (_) => DepartmentRemoteImp(),
        update: (context, apiService, previous) {
          if (previous is DepartmentRemoteImp) {
            previous.apiService = apiService;
          }
          return previous;
        },
      ),
      ProxyProvider<ApiService, AreaRemote>(
        create: (_) => AreaRemoteImp(),
        update: (context, apiService, previous) {
          if (previous is AreaRemoteImp) {
            previous.apiService = apiService;
          }
          return previous;
        },
      ),
      ProxyProvider<ApiService, UserRemote>(
        create: (_) => UserRemoteImp(),
        update: (context, apiService, previous) {
          if (previous is UserRemoteImp) {
            previous.apiService = apiService;
          }
          return previous;
        },
      ),
    ];
  }

  List<SingleChildWidget> generateRepoProvider() {
    return [
      ProxyProvider3<UserInfoLocal, CreateAccountRemote, UserRemote, UserInfoRepo>(
        create: (_) => UserInfoImp(),
        update: (context, userInfoLocal, createAccountRemote, userRemote, previous) {
          if (previous is UserInfoImp) {
            previous.userInfoLocal = userInfoLocal;
            previous.createAccountRemote = createAccountRemote;
            previous.userRemote = userRemote;
          }
          return previous;
        },
      ),
      ProxyProvider2<AuthLocal, AuthRemote, AuthRepo>(
        create: (_) => AuthImp(),
        update: (context, authLocal, authRemote, previous) {
          if (previous is AuthImp) {
            previous.authLocal = authLocal;
            previous.authRemote = authRemote;
          }
          return previous;
        },
      ),
      ProxyProvider<InfoPersonalLocal, InfoPersonalRepo>(
        create: (_) => InfoPersonalRepoImp(),
        update: (context, infoPersonalLocal, previous) {
          if (previous is InfoPersonalRepoImp) {
            previous.infoPersonalLocal = infoPersonalLocal;
          }
          return previous;
        },
      ),
      ProxyProvider<IssueRemote, IssueNeedAssignRepo>(
        create: (_) => IssueNeedAssignImp(),
        update: (context, issueRemote, previous) {
          if (previous is IssueNeedAssignImp) {
            previous.issueNeedAssignRemote = issueRemote;
          }
          return previous;
        },
      ),
      ProxyProvider<ApiService, ProvinceRepo>(
        create: (_) => ProvinceImp(),
        update: (context, apiService, previous) {
          if (previous is ProvinceImp) {
            previous.apiService = apiService;
          }
          return previous;
        },
      ),
      ProxyProvider<IssueRemote, IssueAreaRepo>(
        create: (_) => IssueAreaImp(),
        update: (context, issueRemote, previous) {
          if (previous is IssueAreaImp) {
            previous.issueRemote = issueRemote;
          }
          return previous;
        },
      ),
      ProxyProvider<ApiService, WardRepo>(
        create: (_) => WardImp(),
        update: (context, apiService, previous) {
          if (previous is WardImp) {
            previous.apiService = apiService;
          }
          return previous;
        },
      ),
      ProxyProvider2<PermissionLocal, PermissionRemote, PermissionRepo>(
        create: (_) => PermissionImp(),
        update: (context, permissionLocal, permissionRemote, previous) {
          if (previous is PermissionImp) {
            previous.permissionLocal = permissionLocal;
            previous.permissionRemote = permissionRemote;
          }
          return previous;
        },
      ),
      ProxyProvider<Storage, SplashRepo>(
        create: (_) => SplashImp(),
        update: (context, storage, previous) {
          if (previous is SplashImp) {
            previous.storage = storage;
          }
          return previous;
        },
      ),
      ProxyProvider2<IssueLocal, IssueRemote, IssueRepo>(
        create: (_) => IssueImp(),
        update: (context, issueLocal, issueRemote, previous) {
          if (previous is IssueImp) {
            previous.issueLocal = issueLocal;
            previous.issueRemote = issueRemote;
          }
          return previous;
        },
      ),
      ProxyProvider<ChangePasswordRemote, ChangePassRepo>(
        create: (_) => ChangePassImp(),
        update: (context, changePasswordRemote, previous) {
          if (previous is ChangePassImp) {
            previous.changePasswordRemote = changePasswordRemote;
          }
          return previous;
        },
      ),
      ProxyProvider<ApiService, CategoriesRepo>(
        create: (_) => CategoriesImp(),
        update: (context, apiService, previous) {
          if (previous is CategoriesImp) {
            previous.apiService = apiService;
          }
          return previous;
        },
      ),
      ProxyProvider<ApiService, SendFeedbackRepo>(
        create: (_) => SendFeedbackImp(),
        update: (context, apiService, previous) {
          if (previous is SendFeedbackImp) {
            previous.apiService = apiService;
          }
          return previous;
        },
      ),
      ProxyProvider<OfficerRemote, OfficerRepo>(
        create: (_) => OfficerImp(),
        update: (context, officerRemote, previous) {
          if (previous is OfficerImp) {
            previous.officerRemote = officerRemote;
          }
          return previous;
        },
      ),
      ProxyProvider2<DepartmentRemote, DepartmentLocal, DepartmentRepo>(
        create: (_) => DepartmentRepoImp(),
        update: (context, departmentRemote, departmentLocal, previous) {
          if (previous is DepartmentRepoImp) {
            previous.departmentLocal = departmentLocal;
            previous.departmentRemote = departmentRemote;
          }
          return previous;
        },
      ),
      ProxyProvider<IssueRemote, IssueProcessRepo>(
        create: (_) => IssueProcessImp(),
        update: (context, issueRemote, previous) {
          if (previous is IssueProcessImp) {
            previous.issueRemote = issueRemote;
          }
          return previous;
        },
      ),
      ProxyProvider<IssueRemote, IssueApproveRepo>(
        create: (_) => IssueApproveImp(),
        update: (context, issueRemote, previous) {
          if (previous is IssueApproveImp) {
            previous.issueRemote = issueRemote;
          }
          return previous;
        },
      ),
      ProxyProvider<AreaRemote, AreaRepo>(
        create: (_) => AreaImpRepo(),
        update: (context, areaRemote, previous) {
          if (previous is AreaImpRepo) {
            previous.areaRemote = areaRemote;
          }
          return previous;
        },
      ),
    ];
  }

  List<SingleChildWidget> generateViewModelProvider() {
    return [
      Provider<LocationViewModel>(create: (_) => LocationViewModel()),
      Provider<HelperViewModel>(create: (_) => HelperViewModel()),
      ProxyProvider<InfoPersonalRepo, UserInfoPersonalViewModel>(
        create: (_) => UserInfoPersonalViewModel(),
        update: (context, infoPersonalRepo, previous) {
          previous.infoPersonalRepo = infoPersonalRepo;
          return previous;
        },
      ),
      ProxyProvider<SplashRepo, SplashViewModel>(
          create: (_) => SplashViewModel(),
          update: (context, splashRepo, previous) {
            previous.repo = splashRepo;
            return previous;
          }),
      ProxyProvider2<IssueRepo, AuthRepo, IssueViewModel>(
          create: (_) => IssueViewModel(),
          update: (context, issueRepo, authRepo, previous) {
            previous.issueRepo = issueRepo;
            previous.authRepo = authRepo;
            return previous;
          }),
      ProxyProvider2<ChangePassRepo, AuthRepo, ChangePasswordViewModel>(
          create: (_) => ChangePasswordViewModel(),
          update: (context, changePassRepo, authRepo, previous) {
            previous.changePassRepo = changePassRepo;
            previous.authRepo = authRepo;
            return previous;
          }),
      ProxyProvider<CategoriesRepo, CategoryViewModel>(
          create: (_) => CategoryViewModel(),
          update: (context, categoriesRepo, previous) {
            previous.categoriesRepo = categoriesRepo;
            return previous;
          }),
      ProxyProvider<UserInfoRepo, UserInfoViewModel>(
          create: (context) => UserInfoViewModel(),
          update: (context, userInfoRepo, previous) {
            previous.userInfoRepo = userInfoRepo;
            return previous;
          }),
      ProxyProvider<UserInfoRepo, ResidentInfoViewModel>(
          create: (context) => ResidentInfoViewModel(),
          update: (context, userInfoRepo, previous) {
            previous.userInfoRepo = userInfoRepo;
            return previous;
          }),
      ProxyProvider2<AuthRepo, DepartmentRepo, AuthViewModel>(
          create: (_) => AuthViewModel(),
          update: (context, authRepo, departmentRepo, previous) {
            previous.authRepo = authRepo;
            previous.departmentRepo = departmentRepo;
            return previous;
          }),
      ProxyProvider2<PermissionRepo, AuthRepo, PermissionViewModel>(
        create: (context) => PermissionViewModel(),
        update: (context, permissionRepo, authRepo, previous) {
          previous.authRepo = authRepo;
          previous.permissionRepo = permissionRepo;
          return previous;
        },
      ),
      ProxyProvider<ProvinceRepo, ProvinceInfoViewModel>(
        create: (_) => ProvinceInfoViewModel(),
        update: (context, provinceRepo, previous) {
          previous.provinceRepo = provinceRepo;
          return previous;
        },
      ),
      ProxyProvider<WardRepo, WardInfoViewModel>(
        create: (_) => WardInfoViewModel(),
        update: (context, wardRepo, previous) {
          previous.wardRepo = wardRepo;
          return previous;
        },
      ),
      ProxyProvider<IssueAreaRepo, IssuesAreaViewModel>(
        create: (_) => IssuesAreaViewModel(),
        update: (context, issueAreaRepo, previous) {
          previous.issueAreaRepo = issueAreaRepo;
          return previous;
        },
      ),
      ProxyProvider<SendFeedbackRepo, SendFeedbackViewModel>(
        create: (_) => SendFeedbackViewModel(),
        update: (context, sendFeedbackRepo, previous) {
          previous.sendFeedbackRepo = sendFeedbackRepo;
          return previous;
        },
      ),
      ProxyProvider3<IssueNeedAssignRepo, AuthRepo, DepartmentRepo,
          IssueNeedAssignViewModel>(
        create: (_) => IssueNeedAssignViewModel(),
        update:
            (context, issueNeedAssignRepo, authRepo, departmentRepo, previous) {
          previous.issueNeedAssignRepo = issueNeedAssignRepo;
          previous.authRepo = authRepo;
          previous.departmentRepo = departmentRepo;
          return previous;
        },
      ),
      ProxyProvider3<OfficerRepo, AuthRepo, DepartmentRepo, OfficerViewModel>(
        create: (_) => OfficerViewModel(),
        update: (context, officerRepo, authRepo, departmentRepo, previous) {
          previous.officerRepo = officerRepo;
          previous.authRepo = authRepo;
          previous.departmentRepo = departmentRepo;
          return previous;
        },
      ),
      ProxyProvider2<AuthRepo, DepartmentRepo, DepartmentSupportViewModel>(
        create: (_) => DepartmentSupportViewModel(),
        update: (context, authRepo, departmentRepo, previous) {
          previous.authRepo = authRepo;
          previous.departmentRepo = departmentRepo;
          return previous;
        },
      ),
      ProxyProvider3<IssueRepo, AuthRepo, DepartmentRepo, ReportSpamViewModel>(
        create: (_) => ReportSpamViewModel(),
        update: (context, issueRepo, authRepo, departmentRepo, previous) {
          previous.issueRepo = issueRepo;
          previous.authRepo = authRepo;
          previous.departmentRepo = departmentRepo;
          return previous;
        },
      ),
      ProxyProvider2<AuthRepo, DepartmentRepo, DepartmentAssignUnitViewModel>(
        create: (_) => DepartmentAssignUnitViewModel(),
        update: (context, authRepo, departmentRepo, previous) {
          previous.authRepo = authRepo;
          previous.departmentRepo = departmentRepo;
          return previous;
        },
      ),
      ProxyProvider3<AuthRepo, DepartmentRepo, IssueNeedAssignRepo,
          AssignExecuteViewModel>(
        create: (_) => AssignExecuteViewModel(),
        update:
            (context, authRepo, departmentRepo, issueNeedAssignRepo, previous) {
          previous.authRepo = authRepo;
          previous.departmentRepo = departmentRepo;
          previous.issueNeedAssignRepo = issueNeedAssignRepo;
          return previous;
        },
      ),
      ProxyProvider3<AuthRepo, DepartmentRepo, IssueNeedAssignRepo,
              AssignSupportViewModel>(
          create: (_) => AssignSupportViewModel(),
          update: (context, authRepo, departmentRepo, issueNeedAssignRepo,
              previous) {
            previous.authRepo = authRepo;
            previous.departmentRepo = departmentRepo;
            previous.issueNeedAssignRepo = issueNeedAssignRepo;
            return previous;
          }),
      ProxyProvider2<AuthRepo, IssueProcessRepo, IssueProcessViewModel>(
        create: (_) => IssueProcessViewModel(),
        update: (context, authRepo, issueProcessRepo, previous) {
          previous.authRepo = authRepo;
          previous.issueProcessRepo = issueProcessRepo;
          return previous;
        },
      ),
      Provider<CategoryExecuteViewModel>(
        create: (_) => CategoryExecuteViewModel(),
      ),
      ProxyProvider3<AuthRepo, DepartmentRepo, IssueProcessRepo,
          SendInfoProcessViewModel>(
        create: (_) => SendInfoProcessViewModel(),
        update:
            (context, authRepo, departmentRepo, issueProcessRepo, previous) {
          previous.authRepo = authRepo;
          previous.departmentRepo = departmentRepo;
          previous.issueProcessRepo = issueProcessRepo;
          return previous;
        },
      ),
      ProxyProvider3<AuthRepo, DepartmentRepo, IssueProcessRepo,
          SendInfoSupportViewModel>(
        create: (_) => SendInfoSupportViewModel(),
        update:
            (context, authRepo, departmentRepo, issueProcessRepo, previous) {
          previous.authRepo = authRepo;
          previous.departmentRepo = departmentRepo;
          previous.issueProcessRepo = issueProcessRepo;
          return previous;
        },
      ),
      ProxyProvider3<AuthRepo, DepartmentRepo, IssueApproveRepo,
          SendInfoApproveViewModel>(
        create: (_) => SendInfoApproveViewModel(),
        update:
            (context, authRepo, departmentRepo, issueApproveRepo, previous) {
          previous.authRepo = authRepo;
          previous.departmentRepo = departmentRepo;
          previous.issueApproveRepo = issueApproveRepo;
          return previous;
        },
      ),
      ProxyProvider<IssueRemote, IssueAdminRepo>(
        create: (_) => IssueAdminImp(),
        update: (context, issueRemote, previous) {
          if (previous is IssueAdminImp) {
            previous.issueNeedAssignRemote = issueRemote;
          }
          return previous;
        },
      ),
      ProxyProvider3<IssueAdminRepo, AuthRepo, DepartmentRepo,
          IssueiRootAdminViewModel>(
        create: (_) => IssueiRootAdminViewModel(),
        update: (context, issueAdminRepo, authRepo, departmentRepo, previous) {
          previous.issueAdminRepo = issueAdminRepo;
          previous.authRepo = authRepo;
          previous.departmentRepo = departmentRepo;
          return previous;
        },
      ),
      Provider<HandleComplainViewModel>(
        create: (_) => HandleComplainViewModel(),
      ),
      Provider<CreateIssueObserver>(
        create: (_) => CreateIssueObserver(),
      ),
      ProxyProvider<ApiService, MarkerRemote>(
        create: (_) => MarkerRemoteImp(),
        update: (context, apiService, previous) {
          if (previous is MarkerRemoteImp) {
            previous.apiService = apiService;
          }
          return previous;
        },
      ),
      ProxyProvider<MarkerRemote, MarkerRepo>(
        create: (_) => MarkerImp(),
        update: (context, markerRemote, previous) {
          if (previous is MarkerImp) {
            previous.markerRemoteImp = markerRemote;
          }
          return previous;
        },
      ),
      ProxyProvider2<MarkerRepo, AuthRepo, MarkerViewModel>(
        create: (_) => MarkerViewModel(),
        update: (context, markerRepo, authRepo, previous) {
          if (previous is MarkerViewModel) {
            previous.markerRepo = markerRepo;
            previous.authRepo = authRepo;
          }
          return previous;
        },
      ),
      ProxyProvider3<IssueNeedAssignRepo, AuthRepo, DepartmentRepo,
          IssueiAdminViewModel>(
        create: (_) => IssueiAdminViewModel(),
        update:
            (context, issueNeedAssignRepo, authRepo, departmentRepo, previous) {
          previous.issueNeedAssignRepo = issueNeedAssignRepo;
          previous.authRepo = authRepo;
          previous.departmentRepo = departmentRepo;
          return previous;
        },
      ),
      ProxyProvider<ApiService, DashBoardRemote>(
        create: (_) => DashBoardRemoteImp(),
        update: (context, apiService, previous) {
          if (previous is DashBoardRemoteImp) {
            previous.apiService = apiService;
          }
          return previous;
        },
      ),
      ProxyProvider<DashBoardRemote, DashBoardRepo>(
        create: (_) => DashBoardImp(),
        update: (context, dashBoardRemote, previous) {
          if (previous is DashBoardImp) {
            previous.dashBoardRemoteImp = dashBoardRemote;
          }
          return previous;
        },
      ),
      ProxyProvider3<AuthRepo, DashBoardRepo, DepartmentRepo,
              DashBoardViewModel>(
          create: (_) => DashBoardViewModel(),
          update: (context, authRepo, dashboardRepo, departmentRepo, previous) {
            previous.dashBoardRepo = dashboardRepo;
            previous.authRepo = authRepo;
            previous.departmentRepo = departmentRepo;
            return previous;
          }),
      ProxyProvider<AreaRepo, LocationViewModel>(
        create: (_) => LocationViewModel(),
        update: (context, areaRepo, previous) {
          if (previous is LocationViewModel) {
            previous.areaRepo = areaRepo;
          }
          return previous;
        },
      ),
      Provider<NotificationLocal>(
        create: (_) => NotificationLocalImp(),
      ),
      ProxyProvider<NotificationLocal, NotificationRepo>(
        create: (_) => NotificationImp(),
        update: (context, noificationlocal, previous) {
          if (previous is NotificationImp) {
            previous.notificationLocal = noificationlocal;
          }
          return previous;
        },
      ),

      Provider<DeleteAllNotificaitonObserver>(
        create: (_) => DeleteAllNotificaitonObserver(),
      ),
      ProxyProvider<NotificationRepo, NotificationViewModel>(
        create: (_) => NotificationViewModel(),
        update: (context, noificationRepo, previous) {
          if (previous is NotificationViewModel) {
            previous.notificationRepo = noificationRepo;
          }
          return previous;
        },
      ),

    ];
  }
}

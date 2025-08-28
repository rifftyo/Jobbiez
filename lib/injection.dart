import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:jobbiez/data/datasources/remote_data_source.dart';
import 'package:jobbiez/data/repositories/job_repository_impl.dart';
import 'package:jobbiez/data/repositories/user_repository_impl.dart';
import 'package:jobbiez/domain/repositories/job_repository.dart';
import 'package:jobbiez/domain/repositories/user_repository.dart';
import 'package:jobbiez/domain/usecases/add_review.dart';
import 'package:jobbiez/domain/usecases/apply_job.dart';
import 'package:jobbiez/domain/usecases/check_auth_status.dart';
import 'package:jobbiez/domain/usecases/job_category.dart';
import 'package:jobbiez/domain/usecases/job_detail.dart';
import 'package:jobbiez/domain/usecases/last_job.dart';
import 'package:jobbiez/domain/usecases/login_user.dart';
import 'package:jobbiez/domain/usecases/my_applications.dart';
import 'package:jobbiez/domain/usecases/profile_user.dart';
import 'package:jobbiez/domain/usecases/register_user.dart';
import 'package:jobbiez/domain/usecases/search_job.dart';
import 'package:jobbiez/domain/usecases/top_job.dart';
import 'package:jobbiez/domain/usecases/update_profile.dart';
import 'package:jobbiez/presentation/provider/add_review_provider.dart';
import 'package:jobbiez/presentation/provider/apply_job_provider.dart';
import 'package:jobbiez/presentation/provider/auth_provider.dart';
import 'package:jobbiez/presentation/provider/job_category_provider.dart';
import 'package:jobbiez/presentation/provider/job_detail_provider.dart';
import 'package:jobbiez/presentation/provider/last_job_provider.dart';
import 'package:jobbiez/presentation/provider/login_provider.dart';
import 'package:jobbiez/presentation/provider/my_applications_provider.dart';
import 'package:jobbiez/presentation/provider/profile_user_provider.dart';
import 'package:jobbiez/presentation/provider/register_provider.dart';
import 'package:http/http.dart' as http;
import 'package:jobbiez/presentation/provider/search_job_provider.dart';
import 'package:jobbiez/presentation/provider/tab_job_detail_provider.dart';
import 'package:jobbiez/presentation/provider/tab_job_type_provider.dart';
import 'package:jobbiez/presentation/provider/tab_last_job_provider.dart';
import 'package:jobbiez/presentation/provider/top_job_provider.dart';
import 'package:jobbiez/presentation/provider/update_profile_provider.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(() => LoginProvider(loginUser: locator()));
  locator.registerFactory(() => RegisterProvider(registerUser: locator()));
  locator.registerFactory(() => AuthProvider(checkAuthStatus: locator()));
  locator.registerFactory(() => ProfileUserProvider(profileUser: locator()));
  locator.registerFactory(() => TopJobProvider(topJob: locator()));
  locator.registerFactory(() => TabLastJobProvider());
  locator.registerFactory(() => LastJobProvider(lastJob: locator()));
  locator.registerFactory(() => SearchJobProvider(searchJob: locator()));
  locator.registerFactory(() => TabJobTypeProvider());
  locator.registerFactory(() => TabJobDetailProvider());
  locator.registerFactory(() => JobCategoryProvider(jobCategory: locator()));
  locator.registerFactory(() => JobDetailProvider(detailJob: locator()));
  locator.registerFactory(() => AddReviewProvider(addReview: locator()));
  locator.registerFactory(() => ApplyJobProvider(applyJob: locator()));
  locator.registerFactory(
    () => UpdateProfileProvider(updateProfile: locator()),
  );
  locator.registerFactory(
    () => MyApplicationsProvider(myApplications: locator()),
  );

  // use case
  locator.registerLazySingleton(() => LoginUser(locator()));
  locator.registerLazySingleton(() => RegisterUser(locator()));
  locator.registerLazySingleton(() => CheckAuthStatus(locator()));
  locator.registerLazySingleton(() => ProfileUser(locator()));
  locator.registerLazySingleton(() => TopJob(locator()));
  locator.registerLazySingleton(() => LastJob(locator()));
  locator.registerLazySingleton(() => SearchJob(locator()));
  locator.registerLazySingleton(() => JobCategory(locator()));
  locator.registerLazySingleton(() => DetailJob(locator()));
  locator.registerLazySingleton(() => AddReview(locator()));
  locator.registerLazySingleton(() => ApplyJob(locator()));
  locator.registerLazySingleton(() => UpdateProfile(locator()));
  locator.registerLazySingleton(() => MyApplications(locator()));

  // repository
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: locator(),
      secureStorage: locator(),
    ),
  );
  locator.registerLazySingleton<JobRepository>(
    () => JobRepositoryImpl(remoteDataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: locator(), storage: locator()),
  );

  // helper

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => FlutterSecureStorage());
}

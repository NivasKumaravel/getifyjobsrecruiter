import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/AddBranchModel.dart';
import 'package:getifyjobs/Models/AddCoinsModel.dart';
import 'package:getifyjobs/Models/AddOfferModel.dart';
import 'package:getifyjobs/Models/AddWalletModel.dart';
import 'package:getifyjobs/Models/AllinterviewResutModel.dart';
import 'package:getifyjobs/Models/AppliedCampusCandidateListModel.dart';
import 'package:getifyjobs/Models/ApplyModel.dart';
import 'package:getifyjobs/Models/BranchDetailModel.dart';
import 'package:getifyjobs/Models/BranchListModel.dart';
import 'package:getifyjobs/Models/BulkJobModel.dart';
import 'package:getifyjobs/Models/CallCompletedLogHistoryModel.dart';
import 'package:getifyjobs/Models/CallCompletedModel.dart';
import 'package:getifyjobs/Models/CampusCandidateProfileModel.dart';
import 'package:getifyjobs/Models/CampusDetailModel.dart';
import 'package:getifyjobs/Models/CampusJobListModel.dart';
import 'package:getifyjobs/Models/CampusJobdetailModel.dart';
import 'package:getifyjobs/Models/CampusListModel.dart';
import 'package:getifyjobs/Models/DirectApplyListModel.dart';
import 'package:getifyjobs/Models/DirectCandidateListModel.dart';
import 'package:getifyjobs/Models/DirectDetailsModel.dart';
import 'package:getifyjobs/Models/DirectListModel.dart';
import 'package:getifyjobs/Models/ForgotMobileModel.dart';
import 'package:getifyjobs/Models/IndustryModel.dart';
import 'package:getifyjobs/Models/InterviewModel.dart';
import 'package:getifyjobs/Models/JobModel.dart';
import 'package:getifyjobs/Models/LoginModel.dart';
import 'package:getifyjobs/Models/NewPasswordModel.dart';
import 'package:getifyjobs/Models/NotififcationModel.dart';
import 'package:getifyjobs/Models/ProfileModel.dart';
import 'package:getifyjobs/Models/QualificationModel.dart';
import 'package:getifyjobs/Models/RecentAppliesModel.dart';
import 'package:getifyjobs/Models/RegistrationModel.dart';
import 'package:getifyjobs/Models/RequestCallListModel.dart';
import 'package:getifyjobs/Models/RequestCallModel.dart';
import 'package:getifyjobs/Models/ShortlistedModel.dart';
import 'package:getifyjobs/Models/SkillSetModel.dart';
import 'package:getifyjobs/Models/SpecializationModel.dart';
import 'package:getifyjobs/Models/StatutoryBenefitsModel.dart';
import 'package:getifyjobs/Models/UpdateCandidateJobStatusModel.dart';
import 'package:getifyjobs/Models/WalletHistoryModel.dart';

import '../../Models/OtpModel.dart';
import 'Loading_Overlay.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.interceptors.add(LogInterceptor(responseBody: true)); // For debugging
  return dio;
});


class ApiService {
  final Dio _dio;
  ApiService(this._dio);

  T _fromJson<T>(dynamic json) {
    if (json != null) {
      if (T == RecruiterOtpVerificationModel) {
        return RecruiterOtpVerificationModel.fromJson(json) as T;
      } else if (T == RegistrationModel) {
        return RegistrationModel.fromJson(json) as T;
      } else if (T == LoginModel) {
        return LoginModel.fromJson(json) as T;
      } else if (T == QualificationModel) {
        return QualificationModel.fromJson(json) as T;
      } else if (T == JobModel) {
        return JobModel.fromJson(json) as T;
      } else if (T == CampusListModel) {
        return CampusListModel.fromJson(json) as T;
      } else if (T == CampusDetailModel) {
        return CampusDetailModel.fromJson(json) as T;
      } else if (T == ApplyModel) {
        return ApplyModel.fromJson(json) as T;
      } else if (T == ProfileModel) {
        return ProfileModel.fromJson(json) as T;
      } else if (T == DirectListModel) {
        return DirectListModel.fromJson(json) as T;
      } else if (T == AddBranchModel) {
        return AddBranchModel.fromJson(json) as T;
      } else if (T == BranchDetailModel) {
        return BranchDetailModel.fromJson(json) as T;
      } else if (T == CampusJobListModel) {
        return CampusJobListModel.fromJson(json) as T;
      } else if (T == BulkJobModel) {
        return BulkJobModel.fromJson(json) as T;
      } else if (T == DirectDetailsModel) {
        return DirectDetailsModel.fromJson(json) as T;
      } else if (T == DirectApplyListModel) {
        return DirectApplyListModel.fromJson(json) as T;
      } else if (T == AppliedCampusCandidateModel) {
        return AppliedCampusCandidateModel.fromJson(json) as T;
      } else if (T == CampusJobDetailModel) {
        return CampusJobDetailModel.fromJson(json) as T;
      } else if (T == RecentAppliesModel) {
        return RecentAppliesModel.fromJson(json) as T;
      } else if (T == CandidateCampusProfileModel) {
        return CandidateCampusProfileModel.fromJson(json) as T;
      } else if (T == UpdateCandidateJobSatusModel) {
        return UpdateCandidateJobSatusModel.fromJson(json) as T;
      } else if (T == SpecializationModel) {
        return SpecializationModel.fromJson(json) as T;
      } else if (T == SkillSetModel) {
        return SkillSetModel.fromJson(json) as T;
      } else if (T == DirectCandidateListModel) {
        return DirectCandidateListModel.fromJson(json) as T;
      } else if (T == RequestCallModel) {
        return RequestCallModel.fromJson(json) as T;
      } else if (T == BranchListModel) {
        return BranchListModel.fromJson(json) as T;
      } else if (T == ShortlistedModel) {
        return ShortlistedModel.fromJson(json) as T;
      } else if (T == InterviewModel) {
        return InterviewModel.fromJson(json) as T;
      } else if (T == AllinterviewModel) {
        return AllinterviewModel.fromJson(json) as T;
      }else if (T == IndustryModel) {
        return IndustryModel.fromJson(json) as T;
      }else if (T == AddOfferModel) {
        return AddOfferModel.fromJson(json) as T;
      }else if (T == RequestCallListModel) {
        return RequestCallListModel.fromJson(json) as T;
      }else if (T == AddWalletModel) {
        return AddWalletModel.fromJson(json) as T;
      }else if (T == AddCoinsModel) {
        return AddCoinsModel.fromJson(json) as T;
      }else if (T == WalletHistoryModel) {
        return WalletHistoryModel.fromJson(json) as T;
      }else if (T == StatutoryBenefitsModel) {
        return StatutoryBenefitsModel.fromJson(json) as T;
      }else if (T == ForgotMobileModel) {
        return ForgotMobileModel.fromJson(json) as T;
      }else if (T == NewPasswordModel) {
        return NewPasswordModel.fromJson(json) as T;
      }else if (T == NotificationModel) {
        return NotificationModel.fromJson(json) as T;
      }else if (T == CallCompletedModel) {
        return CallCompletedModel.fromJson(json) as T;
      }else if (T == CallCompletedLogHistoryModel){
        return CallCompletedLogHistoryModel.fromJson(json) as T;
      }
    }

    // Add more conditionals for other model classes as needed
    throw Exception("Unknown model type");
  }

  Future<T> _requestGET<T>(BuildContext context, String path) async {
    // LoadingOverlay.show(context);
    try {
      final response = await _dio.get(path);

      // LoadingOverlay.hide();
      return _fromJson<T>(response.data);
    } on DioException catch (e) {
      // Handle DioError, you can log or display an error message.

      // LoadingOverlay.hide();

      return _fromJson<T>(e.response?.data);
    } catch (e) {
      // Handle other exceptions here

      // LoadingOverlay.hide();

      throw e;
    }
  }

  Future<T> _requestPOST<T>(
    BuildContext context,
    String path, {
    FormData? data,
  }) async {
    // LoadingOverlay.show(context);
    try {
      final response = await _dio.post(path, data: data);

      // LoadingOverlay.hide();
      return _fromJson<T>(response.data);
    } on DioException catch (e) {
      // Handle DioError, you can log or display an error message.

      // LoadingOverlay.hide();

      return _fromJson<T>(e.response?.data);
    } catch (e) {
      // Handle other exceptions here

      LoadingOverlay.hide();

      throw e;
    }
  }

  Future<dynamic> get<T>(BuildContext context, String path) async {
    return _requestGET<T>(context, path);
  }

  Future<T> post<T>(BuildContext context, String path, FormData data) async {
    return _requestPOST<T>(context, path, data: data);
  }
}

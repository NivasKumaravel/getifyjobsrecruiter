enum Environment { DEV, STAGING, PROD }

class ConstantApi {
  static Map<String, dynamic> _config = _Config.debugConstants;

  static String otpVerification = SERVER_ONE + "recruiter/otp_verification";
  static String resentOtpUrl = SERVER_ONE + "recruiter/otp_verification";
  static String registrationUrl = SERVER_ONE + "recruiter/register";
  static String loginUrl = SERVER_ONE + "recruiter/login";
  static String qualificationUrl = SERVER_ONE + "settings/qualification";
  static String singleJobUrl = SERVER_ONE + "jobs/add";
  static String editsingleJobUrl = SERVER_ONE + "jobs/edit";
  static String bulkJobUrl = SERVER_ONE + "campus/recruiter_add_job";
  static String editbulkJobUrl = SERVER_ONE + "campus/recruiter_edit_job";
  static String specilizationUrl = SERVER_ONE + "settings/all_specialization";
  static String campusListUrl = SERVER_ONE + "campus/";
  static String campusDetailUrl = SERVER_ONE + "campus/details";
  static String applyCampusUrl = SERVER_ONE + "campus/recruiter_apply";
  static String profileUrl = SERVER_ONE + "recruiter/profile";
  static String directListUrl = SERVER_ONE + "jobs/";
  static String directJobDetailsUrl = SERVER_ONE + "jobs/details";
  static String editProfileUrl = SERVER_ONE + "recruiter/edit_profile";
  static String addBranchUrl = SERVER_ONE + "branch/add";
  static String editBranchUrl = SERVER_ONE + "branch/edit";
  static String deleteBranchUrl = SERVER_ONE + "branch/delete";
  static String branchDetailUrl = SERVER_ONE + "branch/details";
  static String campusJobListUrl = SERVER_ONE + "campus/recruiter_jobs";
  static String campusJobDetailUrl = SERVER_ONE + "campus/job_details";
  static String branchListUrl = SERVER_ONE + "branch/list";
  static String industryUrl = SERVER_ONE + "settings/industry";
  static String shortlistedUrl =
      SERVER_ONE + "recruiter/shortlisted_candidates";
  static String recentAppliedListUrl =
      SERVER_ONE + "recruiter/applied_jobs_list";
  static String appliedCampusCandidateListUrl =
      SERVER_ONE + "recruiter/applied_campus_jobs_list";
  static String campusCandidateProfileUrl = SERVER_ONE + "recruiter/candidate_profile";
  static String updateCandidateCampusJobSatusUrl =
      SERVER_ONE + "recruiter/update_candidate_campus_job_status";
  static String skillSetUrl = SERVER_ONE + "settings/skills";
  static String directCandidateListUrl =
      SERVER_ONE + "recruiter/applied_direct_jobs_candidate";
  static String requestCallUrl = SERVER_ONE + "recruiter/request_call";
  static String updateDirectJobStatusUrl =
      SERVER_ONE + "recruiter/update_candidate_direct_job_status";

  static String allinterviewjobstatus =
      SERVER_ONE + "recruiter/all_interview_job_status";
  static String alljobresult = SERVER_ONE + "recruiter/all_job_result_status";
  static String addOfferUrl = SERVER_ONE + "recruiter/add_offer_letter";
  static String rescheduleDateUrl = SERVER_ONE + "jobs/reschedule_interview";
  static String requestCallListUrl = SERVER_ONE + "recruiter/request_call_list";
  static String addWalletUrl = SERVER_ONE + "settings/wallet";
  static String addCoinsUrl = SERVER_ONE + "recruiter/add_coins";
  static String walletHistoryUrl = SERVER_ONE + "recruiter/coins_history";
  static String benefitsUrl = SERVER_ONE + "settings/benefits";
  static String forgotMobileUrl = SERVER_ONE + "recruiter/forgot_password";
  static String forgotOtpUrl = SERVER_ONE + "recruiter/forgot_otp_verification";
  static String newPasswordUrl = SERVER_ONE + "recruiter/reset_password";
  static String updateJobStatus = SERVER_ONE + "jobs/update_job_status";
  static String notificationUrl = SERVER_ONE + "recruiter/notification";


  static String SOMETHING_WRONG = "Some thing wrong";
  static String NO_INTERNET = "No internet Connection";
  static String BAD_RESPONSE = "Bad Response";
  static String UNAUTHORIZED = "Un Athurized";

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugConstants;
        break;
      case Environment.STAGING:
        _config = _Config.stagingConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get SERVER_ONE {
    return _config[_Config.SERVER_ONE];
  }

  static get BUILD_VARIANTS {
    return _config[_Config.BUILD_VARIANTS];
  }
}

class _Config {
  static const SERVER_ONE = "";
  static const BUILD_VARIANTS = "getifyJobs-dev";

  static Map<String, dynamic> debugConstants = {
    SERVER_ONE: "https://qa.getifyjobs.com/api/",
    BUILD_VARIANTS: "getifyJobs-dev",
  };

  static Map<String, dynamic> stagingConstants = {
    SERVER_ONE: "https://qa.getifyjobs.com/api/",
    BUILD_VARIANTS: "getifyJobs-dev",
  };

  static Map<String, dynamic> prodConstants = {
    SERVER_ONE: "https://qa.getifyjobs.com/api/",
    BUILD_VARIANTS: "getifyJobs-dev",
  };
}

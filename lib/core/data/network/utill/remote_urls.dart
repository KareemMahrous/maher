class RemoteURLs {
  static const loginPath = "m/MobileAccount/Login";
  static const forgetPasswordPath = "m/MobileAccount/SendResetPasswordOTP";
  static const verifyOtpPath = "m/MobileAccount/VerifyResetPasswordOTP";
  static const changePasswordPath = "m/MobileAccount/ResetPassword";
  static const logoutPath = "m/MobileAccount/Logout";
  static const refreshTokenPath = "m/MobileAccount/RefreshToken";

  static const getSignaturePath = "m/MobileSignature/GetAllMobileSignatures";
  static const createSignaturePath = "m/MobileSignature/CreateSignatureCommand";
  static const updateSignaturePath = "m/MobileSignature/UpdateSignatureCommand";
  static const deleteSignaturePath = "m/MobileSignature/DeleteSignatureCommand";

  static const getDepartmentTransactions =
      "MobileManagersBox/GetDepartmentCTSs";
  static const getGetForSigningBoxDataAsync =
      "MobileManagersBox/GetDraftsForSignaturePurposes";
  static const getPublicAnnouncementBoxDataAsync =
      "MobileManagersBox/GetPublicAnnouncementCTSs";
  static const getDecisionAndOperationOrderBoxDataAsync =
      "MobileManagersBox/GetDecisionAndOperationOrderCTSs";
  static const getMyTransactions = "MobileManagersBox/GetMyCTSs";
  static const getOutBoxDataAsync = "MobileManagersBox/GetOutTransactions";
  static const getClosedBoxDataAsync =
      "MobileManagersBox/GetClosedTransactions";
  static const getApprovedDraftsBoxDataAsync =
      "MobileManagersBox/GetApprovedDrafts";
  static const getWaitingAttachmentsBoxDataAsync =
      "MobileManagersBox/GetWaitingAttachmentsTransactions";
  static const getRejectedBoxDataAsync =
      "MobileManagersBox/GetRejectedTransactions";

  static const getForGuidanceDataAsync =
      "MobileExcellencyBox/GetCTSsForGuidancePurposes";
  static const getGetForSigningExcellencyBoxDataAsync =
      "MobileExcellencyBox/GetTransactionsForSignaturePurposes";
  static const getExcellencyOutBoxForGuidance =
      "MobileExcellencyBox/GetOutCTSsForGuidancePurposes";
  static const getExcellencyOutBoxForSigning =
      "MobileExcellencyBox/GetOutTransactionsForSignaturePurposes";
  static const getWaitingAutoApprovalDraftsBoxDataAsync =
      "MobileBoxesCounters/GetWaitingAutoApprovalDraftsBoxDataAsync";
  static const waitDraftApproval = "MobileDraft/WaitDraftApproval";
  static const cancelWaitingDraftApproval =
      "MobileDraft/CancelWaitingDraftApproval";

  static const getBoxCountAsync = "MobileBoxesCounters/GetBoxesCounters";
  static const getBoxPriorityCountAsync =
      "MobileBoxesCounters/GetTransferPrioritiesCountersByBoxType";

  static const getAllBoxDataAsync = "MobileBox/GetAllBoxDataAsync";
  static const getInBoxDataAsync = "MobileBox/GetInBoxDataAsync";

  static const getDraftsWaitingApprovalBoxDataAsync =
      "MobileBox/GetRejectedTransactionsDataAsync";

  static const getOutBoxExcellencyDataAsync =
      "MobileBox/GetExcellencyOutTransactionsDataAsync";

  static const getTransactionDetails =
      "MobileCorrespondence/GetCorrespondenceByID";
  static const getTransactionTrack =
      "MobileTracking/GetTransactionTrackingAsync";
  static const getDraftDetails = "MobileDraft/GetDraftBySendingOwnerID";
  static const sendNormalCorrespondence =
      "MobileCorrespondence/SendNormalCorrespondence";
  static const sendCopyCorrespondence =
      "MobileCorrespondence/SendCorrespondenceCopies";
  static const sendNormalDraft = "MobileDraft/SendNormalDraft";
  static const sendCopyDraft = "MobileDraft/SendDraftCopies";

  static const recallDraft = "MobileDraft/RecallDraft";
  static const recallCorrespondence =
      "MobileCorrespondence/RecallCorrespondence";

  static const behalfSignatureDraft = "MobileDraft/ApproveDraftOnBehalf";

  static const getAllTypes = "MobileLookups/GetAllDorpDowns";

  static const rejectCorrespondenceTransaction =
      "MobileCorrespondence/RejectCorrespondence";
  static const rejectDraftTransaction = "MobileDraft/RejectDraft";
  static const acceptCorrespondenceTransaction =
      "MobileCorrespondence/ReceiveCorrespondence";
  static const acceptDraftTransaction = "MobileDraft/ReceiveDraft";
  static const approveCorrespondenceTransaction = "MobileDraft/ApproveDraft";
  static const approveDraftTransaction = "MobileDraft/ApproveDraft";
  static const closeCorrespondenceTransaction =
      "MobileCorrespondence/CloseCorrespondence";
  static const closeDraftTransaction = "MobileDraft/CloseDraft";
  static const returnDraftTransaction = "/MobileDraft/ReturnDraft";
  static const returnCorrespondenceTransaction =
      "MobileCorrespondence/ReturnCorrespondence";

  static const getGroups = "m/MobileDepartmentsGroup/GetGroupsList";
  static const getGroupDetails = "m/MobileDepartmentsGroup/GetGroupDetails";
  static const getPurposes = "MobileTransferPurpose/GetTransferPurposes";
  static const getSendableUsers = "MobileUser/GetSendableUsersForLoginUser";
  static const getDepartmentPath =
      "m/MobileDepartment/GetSendableDepartmentsForLoginUser";
  static const getExternalDepartments =
      "MobileExternalOrganization/GetAllExternalOrganizationList";
  static const getFavoriteDepartmentPath =
      "m/MobileDepartment/GetFavoriteDepartments";
  static const addFavoriteDepartmentPath =
      "m/MobileDepartment/AddFavouriteDepartment";
  static const deleteFavoriteDepartmentPath =
      "m/MobileDepartment/DeleteFavouriteDepartment";

  static const getDraftQrPath = "MobileDraftAttachment/GetDraftBarcode";
  static const getCorrespondenceQrPath =
      "MobileCorrespondenceAttachment/GetCorrespondenceBarcode";

  static const savePdf = "m/MobileDepartment/savePdf";

  static const getDraftAttachment = "MobileDraftAttachment/GetSendingOwnerFile";
  static const getDraftWithoutWaterMarkAttachment =
      "MobileDraftAttachment/GetSendingOwnerFileWithoutWatermark";
  static const getCorrespondenceAttachment =
      "MobileCorrespondenceAttachment/GetCTSFile";
  static const getCorrespondenceWithoutWaterMarkAttachment =
      "MobileCorrespondenceAttachment/GetCTSFileWithoutWatermark";

  static const addCorrespondenceAdditionAnnotation =
      "MobileCorrespondenceAttachment/AddAdditionToCTSFile";
  static const addDraftAdditionAnnotation =
      "MobileDraftAttachment/AddAdditionToDraftFile";

  static const deleteCorrespondenceAdditionAnnotation =
      "MobileCorrespondenceAttachment/DeleteCTSFileAddition";
  static const deleteDraftAdditionAnnotation =
      "MobileDraftAttachment/DeleteAddition";

  static const updateCorrespondenceAdditionAnnotation =
      "MobileCorrespondenceAttachment/EditCTSFileAddition";
  static const updateDraftAdditionAnnotation =
      "MobileDraftAttachment/EditDraftFileAddition";

  static const downloadDraftFileWithWatermark =
      "MobileDraftAttachment/DownloadDraftFileWithWatermark";
  static const downloadDraftFileWithoutWatermark =
      "MobileDraftAttachment/DownloadDraftFileWithoutWatermark";
  static const downloadCTSFileWithWatermark =
      "MobileCorrespondenceAttachment/DownloadCTSFileWithWatermark";
  static const downloadCTSFileWithoutWatermark =
      "MobileCorrespondenceAttachment/DownloadCTSFileWithoutWatermark";

  static const attachCtsFile = "MobileCorrespondenceAttachment/AttachCTSFile";

  static const getSearchResultsInCTSsAsync =
      "MobileCorrespondence/GetSearchResultsInCTSsAsync";
  static const getSearchResultsInDraftsAsync =
      "MobileDraft/GetSearchResultsInDraftsAsync";

  static const getUserNotificationsByType =
      "MobileNotification/GetUserNotificationsByType";
  static const receiveUserNotification =
      "MobileNotification/ReciveUserNotification";

  static const getUserProfile = "MobileUser/GetUserProfile";

  static const getMyDelegationsPath = "m/MobileDelegation/GetAllDelegations";
  static const getDelegationByIdPath = "m/MobileDelegation/GetDelegationById";
  static const changeDelegationStatusPath =
      "m/MobileDelegation/ChangeDelegationStatus";
  static const getUsersByDepartmentPath =
      "MobileUser/GetAllUsersByDepartmentListPaggedList";
}

class EndPoints {
  static const examples = 'examples';
  static const exampleDetails = 'examples/details';
  static const createExample = 'examples/create';
  static const updateExample = 'examples/update';
  static const deleteExample = 'examples/delete';
}

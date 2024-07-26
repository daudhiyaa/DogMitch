//
//  VerificationState.swift
//  MC3
//
//  Created by Daud on 25/07/24.
//

import Foundation

enum VerificationState {
    case notUploaded
    case waitingVerification
    case vaccineRejected
    case medicalRejected
    case stamboomRejected
    case vaccineAndMedicalRejected
    case vaccineAndStamboomRejected
    case medicalAndStamboomRejected
    case allDocumentRejected
    case verified
}

func checkVerificationState(dog: Dog) -> VerificationState {
    if dog.medicalRecord == "" && dog.vaccine == "" {
        return .notUploaded
    } else if (dog.medicalRecord != "" && dog.vaccine != "") && (!dog.isMedicalVerified && !dog.isVaccineVerified) {
        return .waitingVerification
    } else if !dog.isMedicalVerified && dog.isVaccineVerified {
        return .medicalRejected
    } else if dog.isMedicalVerified && !dog.isVaccineVerified {
        return .vaccineRejected
    } else if dog.stamboom != "" && !dog.isStamboomVerified {
        return .stamboomRejected
    } else if (dog.medicalRecord != "" && !dog.isMedicalVerified) && (dog.vaccine != "" && !dog.isVaccineVerified) {
        return .vaccineAndMedicalRejected
    } else if (dog.medicalRecord != "" && !dog.isMedicalVerified) && (dog.stamboom != "" && !dog.isStamboomVerified) && dog.isVaccineVerified {
        return .medicalAndStamboomRejected
    } else if (dog.vaccine != "" && !dog.isVaccineVerified) && (dog.stamboom != "" && !dog.isStamboomVerified) && dog.isMedicalVerified {
        return .vaccineAndStamboomRejected
    } else if (!dog.isMedicalVerified && !dog.isVaccineVerified && !dog.isStamboomVerified)
                && (dog.medicalRecord == "" && dog.vaccine == "" && dog.stamboom != "") {
        return .allDocumentRejected
    }
    return .verified
}

func getVerificationStatusMessage(verificationState: VerificationState) -> String {
    switch verificationState {
    case .notUploaded:
        return "You haven't uploaded any medical document."
    case .waitingVerification:
        return "Your account will be verified within a maximum of 24 hours."
    case .medicalRejected:
        return "Your medical document is rejected. Please edit your document & reupload it."
    case .vaccineRejected:
        return "Your vaccine document is rejected. Please edit your document & reupload it."
    case .stamboomRejected:
        return "Your stamboom document is rejected. Please edit your document & reupload it."
    case .vaccineAndMedicalRejected:
        return "Your vaccine and medical document are rejected. Please edit your document & reupload it."
    case .medicalAndStamboomRejected:
        return "Your medical and stamboom document are rejected. Please edit your document & reupload it."
    case .vaccineAndStamboomRejected:
        return "Your vaccine and stamboom document are rejected. Please edit your document & reupload it."
    case .allDocumentRejected:
        return "All of your document are rejected."
    default:
        return "Your profile is verified."
    }
}

func getVerificationStatusIcon(verificationState: VerificationState) -> String {
    switch verificationState {
    case .waitingVerification:
        return "clock"
    default:
        return "exclamationmark.triangle"
    }
}

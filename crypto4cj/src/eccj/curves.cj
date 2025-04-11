/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

package crypto4cj.eccj

public enum CurvesId <: ToString {
    | NID_secp112r1
    | NID_secp112r2
    | NID_secp128r1
    | NID_secp128r2
    | NID_secp160k1
    | NID_secp160r1
    | NID_secp160r2
    | NID_secp192k1
    | NID_secp224k1
    | NID_secp224r1
    | NID_secp256k1
    | NID_secp384r1
    | NID_secp521r1
    /* X9.62 curves */
    | NID_X9_62_prime192v1
    | NID_X9_62_prime192v2
    | NID_X9_62_prime192v3
    | NID_X9_62_prime239v1
    | NID_X9_62_prime239v2
    | NID_X9_62_prime239v3
    | NID_X9_62_prime256v1
    /* characteristic two field curves */
    /* NIST/SECG curves */
    | NID_sect113r1
    | NID_sect113r2
    | NID_sect131r1
    | NID_sect131r2
    | NID_sect163k1
    | NID_sect163r1
    | NID_sect163r2
    | NID_sect193r1
    | NID_sect193r2
    | NID_sect233k1
    | NID_sect233r1
    | NID_sect239k1
    | NID_sect283k1
    | NID_sect283r1
    | NID_sect409k1
    | NID_sect409r1
    | NID_sect571k1
    | NID_sect571r1
    /* X9.62 curves */
    | NID_X9_62_c2pnb163v1
    | NID_X9_62_c2pnb163v2
    | NID_X9_62_c2pnb163v3
    | NID_X9_62_c2pnb176v1
    | NID_X9_62_c2tnb191v1
    | NID_X9_62_c2tnb191v2
    | NID_X9_62_c2tnb191v3
    | NID_X9_62_c2pnb208w1
    | NID_X9_62_c2tnb239v1
    | NID_X9_62_c2tnb239v2
    | NID_X9_62_c2tnb239v3
    | NID_X9_62_c2pnb272w1
    | NID_X9_62_c2pnb304w1
    | NID_X9_62_c2tnb359v1
    | NID_X9_62_c2pnb368w1
    | NID_X9_62_c2tnb431r1
    /*
     * the WAP/WTLS curves [unlike SECG, spec has its own OIDs for curves
     * from X9.62]
     */
    | NID_wap_wsg_idm_ecid_wtls1
    | NID_wap_wsg_idm_ecid_wtls3
    | NID_wap_wsg_idm_ecid_wtls4
    | NID_wap_wsg_idm_ecid_wtls5
    | NID_wap_wsg_idm_ecid_wtls6
    | NID_wap_wsg_idm_ecid_wtls7
    | NID_wap_wsg_idm_ecid_wtls8
    | NID_wap_wsg_idm_ecid_wtls9
    | NID_wap_wsg_idm_ecid_wtls10
    | NID_wap_wsg_idm_ecid_wtls11
    | NID_wap_wsg_idm_ecid_wtls12
    /* IPSec curves */
    | NID_ipsec3
    | NID_ipsec4
    /* brainpool curves */
    | NID_brainpoolP160r1
    | NID_brainpoolP160t1
    | NID_brainpoolP192r1
    | NID_brainpoolP192t1
    | NID_brainpoolP224r1
    | NID_brainpoolP224t1
    | NID_brainpoolP256r1
    | NID_brainpoolP256t1
    | NID_brainpoolP320r1
    | NID_brainpoolP320t1
    | NID_brainpoolP384r1
    | NID_brainpoolP384t1
    | NID_brainpoolP512r1
    | NID_brainpoolP512t1
    /* SM2 curve */
    | NID_sm2
    | NID_undef

    /*
     * Get elliptic curve id
     *
     * @return Int32
     */
    public func getCurveId(): Int32 {
        match (this) {
            case NID_secp112r1 => 704
            case NID_secp112r2 => 705
            case NID_secp128r1 => 706
            case NID_secp128r2 => 707
            case NID_secp160k1 => 708
            case NID_secp160r1 => 709
            case NID_secp160r2 => 710
            case NID_secp192k1 => 711
            case NID_secp224k1 => 712
            case NID_secp224r1 => 713
            case NID_secp256k1 => 714
            case NID_secp384r1 => 715
            case NID_secp521r1 => 716
            case NID_X9_62_prime192v1 => 409
            case NID_X9_62_prime192v2 => 410
            case NID_X9_62_prime192v3 => 411
            case NID_X9_62_prime239v1 => 412
            case NID_X9_62_prime239v2 => 413
            case NID_X9_62_prime239v3 => 414
            case NID_X9_62_prime256v1 => 415
            case NID_sect113r1 => 717
            case NID_sect113r2 => 718
            case NID_sect131r1 => 719
            case NID_sect131r2 => 720
            case NID_sect163k1 => 721
            case NID_sect163r1 => 722
            case NID_sect163r2 => 723
            case NID_sect193r1 => 724
            case NID_sect193r2 => 725
            case NID_sect233k1 => 726
            case NID_sect233r1 => 727
            case NID_sect239k1 => 728
            case NID_sect283k1 => 729
            case NID_sect283r1 => 730
            case NID_sect409k1 => 731
            case NID_sect409r1 => 732
            case NID_sect571k1 => 733
            case NID_sect571r1 => 734
            case NID_X9_62_c2pnb163v1 => 684
            case NID_X9_62_c2pnb163v2 => 685
            case NID_X9_62_c2pnb163v3 => 686
            case NID_X9_62_c2pnb176v1 => 687
            case NID_X9_62_c2tnb191v1 => 688
            case NID_X9_62_c2tnb191v2 => 689
            case NID_X9_62_c2tnb191v3 => 690
            case NID_X9_62_c2pnb208w1 => 693
            case NID_X9_62_c2tnb239v1 => 694
            case NID_X9_62_c2tnb239v2 => 695
            case NID_X9_62_c2tnb239v3 => 696
            case NID_X9_62_c2pnb272w1 => 699
            case NID_X9_62_c2pnb304w1 => 700
            case NID_X9_62_c2tnb359v1 => 701
            case NID_X9_62_c2pnb368w1 => 702
            case NID_X9_62_c2tnb431r1 => 703
            case NID_wap_wsg_idm_ecid_wtls1 => 735
            case NID_wap_wsg_idm_ecid_wtls3 => 736
            case NID_wap_wsg_idm_ecid_wtls4 => 737
            case NID_wap_wsg_idm_ecid_wtls5 => 738
            case NID_wap_wsg_idm_ecid_wtls6 => 739
            case NID_wap_wsg_idm_ecid_wtls7 => 740
            case NID_wap_wsg_idm_ecid_wtls8 => 741
            case NID_wap_wsg_idm_ecid_wtls9 => 742
            case NID_wap_wsg_idm_ecid_wtls10 => 743
            case NID_wap_wsg_idm_ecid_wtls11 => 744
            case NID_wap_wsg_idm_ecid_wtls12 => 745
            case NID_ipsec3 => 749
            case NID_ipsec4 => 750
            case NID_brainpoolP160r1 => 921
            case NID_brainpoolP160t1 => 922
            case NID_brainpoolP192r1 => 923
            case NID_brainpoolP192t1 => 924
            case NID_brainpoolP224r1 => 925
            case NID_brainpoolP224t1 => 926
            case NID_brainpoolP256r1 => 927
            case NID_brainpoolP256t1 => 928
            case NID_brainpoolP320r1 => 929
            case NID_brainpoolP320t1 => 930
            case NID_brainpoolP384r1 => 931
            case NID_brainpoolP384t1 => 932
            case NID_brainpoolP512r1 => 933
            case NID_brainpoolP512t1 => 934
            case NID_sm2 => 1172
            case NID_undef => 0
        }
    }
 
    public func toString(): String {
        match (this) {
            case NID_secp112r1 => "NID_secp112r1"
            case NID_secp112r2 => "NID_secp112r2"
            case NID_secp128r1 => "NID_secp128r1"
            case NID_secp128r2 => "NID_secp128r2"
            case NID_secp160k1 => "NID_secp160k1"
            case NID_secp160r1 => "NID_secp160r1"
            case NID_secp160r2 => "NID_secp160r2"
            case NID_secp192k1 => "NID_secp192k1"
            case NID_secp224k1 => "NID_secp224k1"
            case NID_secp224r1 => "NID_secp224r1"
            case NID_secp256k1 => "NID_secp256k1"
            case NID_secp384r1 => "NID_secp384r1"
            case NID_secp521r1 => "NID_secp521r1"
            case NID_X9_62_prime192v1 => "NID_X9_62_prime192v1"
            case NID_X9_62_prime192v2 => "NID_X9_62_prime192v2"
            case NID_X9_62_prime192v3 => "NID_X9_62_prime192v3"
            case NID_X9_62_prime239v1 => "NID_X9_62_prime239v1"
            case NID_X9_62_prime239v2 => "NID_X9_62_prime239v2"
            case NID_X9_62_prime239v3 => "NID_X9_62_prime239v3"
            case NID_X9_62_prime256v1 => "NID_X9_62_prime256v1"
            case NID_sect113r1 => "NID_sect113r1"
            case NID_sect113r2 => "NID_sect113r2"
            case NID_sect131r1 => "NID_sect131r1"
            case NID_sect131r2 => "NID_sect131r2"
            case NID_sect163k1 => "NID_sect163k1"
            case NID_sect163r1 => "NID_sect163r1"
            case NID_sect163r2 => "NID_sect163r2"
            case NID_sect193r1 => "NID_sect193r1"
            case NID_sect193r2 => "NID_sect193r2"
            case NID_sect233k1 => "NID_sect233k1"
            case NID_sect233r1 => "NID_sect233r1"
            case NID_sect239k1 => "NID_sect239k1"
            case NID_sect283k1 => "NID_sect283k1"
            case NID_sect283r1 => "NID_sect283r1"
            case NID_sect409k1 => "NID_sect409k1"
            case NID_sect409r1 => "NID_sect409r1"
            case NID_sect571k1 => "NID_sect571k1"
            case NID_sect571r1 => "NID_sect571r1"
            case NID_X9_62_c2pnb163v1 => "NID_X9_62_c2pnb163v1"
            case NID_X9_62_c2pnb163v2 => "NID_X9_62_c2pnb163v2"
            case NID_X9_62_c2pnb163v3 => "NID_X9_62_c2pnb163v3"
            case NID_X9_62_c2pnb176v1 => "NID_X9_62_c2pnb176v1"
            case NID_X9_62_c2tnb191v1 => "NID_X9_62_c2tnb191v1"
            case NID_X9_62_c2tnb191v2 => "NID_X9_62_c2tnb191v2"
            case NID_X9_62_c2tnb191v3 => "NID_X9_62_c2tnb191v3"
            case NID_X9_62_c2pnb208w1 => "NID_X9_62_c2pnb208w1"
            case NID_X9_62_c2tnb239v1 => "NID_X9_62_c2tnb239v1"
            case NID_X9_62_c2tnb239v2 => "NID_X9_62_c2tnb239v2"
            case NID_X9_62_c2tnb239v3 => "NID_X9_62_c2tnb239v3"
            case NID_X9_62_c2pnb272w1 => "NID_X9_62_c2pnb272w1"
            case NID_X9_62_c2pnb304w1 => "NID_X9_62_c2pnb304w1"
            case NID_X9_62_c2tnb359v1 => "NID_X9_62_c2tnb359v1"
            case NID_X9_62_c2pnb368w1 => "NID_X9_62_c2pnb368w1"
            case NID_X9_62_c2tnb431r1 => "NID_X9_62_c2tnb431r1"
            case NID_wap_wsg_idm_ecid_wtls1 => "NID_wap_wsg_idm_ecid_wtls1"
            case NID_wap_wsg_idm_ecid_wtls3 => "NID_wap_wsg_idm_ecid_wtls3"
            case NID_wap_wsg_idm_ecid_wtls4 => "NID_wap_wsg_idm_ecid_wtls4"
            case NID_wap_wsg_idm_ecid_wtls5 => "NID_wap_wsg_idm_ecid_wtls5"
            case NID_wap_wsg_idm_ecid_wtls6 => "NID_wap_wsg_idm_ecid_wtls6"
            case NID_wap_wsg_idm_ecid_wtls7 => "NID_wap_wsg_idm_ecid_wtls7"
            case NID_wap_wsg_idm_ecid_wtls8 => "NID_wap_wsg_idm_ecid_wtls8"
            case NID_wap_wsg_idm_ecid_wtls9 => "NID_wap_wsg_idm_ecid_wtls9"
            case NID_wap_wsg_idm_ecid_wtls10 => "NID_wap_wsg_idm_ecid_wtls10"
            case NID_wap_wsg_idm_ecid_wtls11 => "NID_wap_wsg_idm_ecid_wtls11"
            case NID_wap_wsg_idm_ecid_wtls12 => "NID_wap_wsg_idm_ecid_wtls12"
            case NID_ipsec3 => "NID_ipsec3"
            case NID_ipsec4 => "NID_ipsec4"
            case NID_brainpoolP160r1 => "NID_brainpoolP160r1"
            case NID_brainpoolP160t1 => "NID_brainpoolP160t1"
            case NID_brainpoolP192r1 => "NID_brainpoolP192r1"
            case NID_brainpoolP192t1 => "NID_brainpoolP192t1"
            case NID_brainpoolP224r1 => "NID_brainpoolP224r1"
            case NID_brainpoolP224t1 => "NID_brainpoolP224t1"
            case NID_brainpoolP256r1 => "NID_brainpoolP256r1"
            case NID_brainpoolP256t1 => "NID_brainpoolP256t1"
            case NID_brainpoolP320r1 => "NID_brainpoolP320r1"
            case NID_brainpoolP320t1 => "NID_brainpoolP320t1"
            case NID_brainpoolP384r1 => "NID_brainpoolP384r1"
            case NID_brainpoolP384t1 => "NID_brainpoolP384t1"
            case NID_brainpoolP512r1 => "NID_brainpoolP512r1"
            case NID_brainpoolP512t1 => "NID_brainpoolP512t1"
            case NID_sm2 => "NID_sm2"
            case NID_undef => "NID_undef"
        }
    }
}

func getCurveName(id: Int32): CurvesId {
    let name: CurvesId = match (Int64(id)) {
        case 704 => NID_secp112r1
        case 705 => NID_secp112r2
        case 706 => NID_secp128r1
        case 707 => NID_secp128r2
        case 708 => NID_secp160k1
        case 709 => NID_secp160r1
        case 710 => NID_secp160r2
        case 711 => NID_secp192k1
        case 712 => NID_secp224k1
        case 713 => NID_secp224r1
        case 714 => NID_secp256k1
        case 715 => NID_secp384r1
        case 716 => NID_secp521r1
        case 409 => NID_X9_62_prime192v1
        case 410 => NID_X9_62_prime192v2
        case 411 => NID_X9_62_prime192v3
        case 412 => NID_X9_62_prime239v1
        case 413 => NID_X9_62_prime239v2
        case 414 => NID_X9_62_prime239v3
        case 415 => NID_X9_62_prime256v1
        case 717 => NID_sect113r1
        case 718 => NID_sect113r2
        case 719 => NID_sect131r1
        case 720 => NID_sect131r2
        case 721 => NID_sect163k1
        case 722 => NID_sect163r1
        case 723 => NID_sect163r2
        case 724 => NID_sect193r1
        case 725 => NID_sect193r2
        case 726 => NID_sect233k1
        case 727 => NID_sect233r1
        case 728 => NID_sect239k1
        case 729 => NID_sect283k1
        case 730 => NID_sect283r1
        case 731 => NID_sect409k1
        case 732 => NID_sect409r1
        case 733 => NID_sect571k1
        case 734 => NID_sect571r1
        case 684 => NID_X9_62_c2pnb163v1
        case 685 => NID_X9_62_c2pnb163v2
        case 686 => NID_X9_62_c2pnb163v3
        case 687 => NID_X9_62_c2pnb176v1
        case 688 => NID_X9_62_c2tnb191v1
        case 689 => NID_X9_62_c2tnb191v2
        case 690 => NID_X9_62_c2tnb191v3
        case 693 => NID_X9_62_c2pnb208w1
        case 694 => NID_X9_62_c2tnb239v1
        case 695 => NID_X9_62_c2tnb239v2
        case 696 => NID_X9_62_c2tnb239v3
        case 699 => NID_X9_62_c2pnb272w1
        case 700 => NID_X9_62_c2pnb304w1
        case 701 => NID_X9_62_c2tnb359v1
        case 702 => NID_X9_62_c2pnb368w1
        case 703 => NID_X9_62_c2tnb431r1
        case 735 => NID_wap_wsg_idm_ecid_wtls1
        case 736 => NID_wap_wsg_idm_ecid_wtls3
        case 737 => NID_wap_wsg_idm_ecid_wtls4
        case 738 => NID_wap_wsg_idm_ecid_wtls5
        case 739 => NID_wap_wsg_idm_ecid_wtls6
        case 740 => NID_wap_wsg_idm_ecid_wtls7
        case 741 => NID_wap_wsg_idm_ecid_wtls8
        case 742 => NID_wap_wsg_idm_ecid_wtls9
        case 743 => NID_wap_wsg_idm_ecid_wtls10
        case 744 => NID_wap_wsg_idm_ecid_wtls11
        case 745 => NID_wap_wsg_idm_ecid_wtls12
        case 749 => NID_ipsec3
        case 750 => NID_ipsec4
        case 921 => NID_brainpoolP160r1
        case 922 => NID_brainpoolP160t1
        case 923 => NID_brainpoolP192r1
        case 924 => NID_brainpoolP192t1
        case 925 => NID_brainpoolP224r1
        case 926 => NID_brainpoolP224t1
        case 927 => NID_brainpoolP256r1
        case 928 => NID_brainpoolP256t1
        case 929 => NID_brainpoolP320r1
        case 930 => NID_brainpoolP320t1
        case 931 => NID_brainpoolP384r1
        case 932 => NID_brainpoolP384t1
        case 933 => NID_brainpoolP512r1
        case 934 => NID_brainpoolP512t1
        case 1172 => NID_sm2
        case _ => NID_undef
    }
    return name
}
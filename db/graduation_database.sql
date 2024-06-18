-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 22, 2024 at 08:24 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `graduation_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `applies`
--

CREATE TABLE `applies` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` enum('pending','accepted-cv-round','accepted-interview-round','rejected') NOT NULL DEFAULT 'pending',
  `response` text DEFAULT NULL,
  `resume_id` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

CREATE TABLE `bookmarks` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chats`
--

CREATE TABLE `chats` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `province_id` int(11) DEFAULT NULL,
  `employees` int(11) NOT NULL,
  `introduction` text DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `website` varchar(255) NOT NULL,
  `contact_mail` varchar(255) NOT NULL,
  `average_salary_rating` float DEFAULT NULL,
  `average_working_space_rating` float DEFAULT NULL,
  `average_colleague_rating` float DEFAULT NULL,
  `average_rating` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `name`, `cover_image`, `location`, `country`, `province_id`, `employees`, `introduction`, `logo`, `website`, `contact_mail`, `average_salary_rating`, `average_working_space_rating`, `average_colleague_rating`, `average_rating`) VALUES
(1, 'FPT Information System', NULL, 'Tầng 22 toà nhà Keangnam Landmark 72, E6 Phạm Hùng, Nam Từ Liêm, Hà Nội', 'VN', 1, 5000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/fpt-information-system-0568949376dcab14abfb13e3e271447f-6548a75395c0b.jpg', 'https://www.fis.com.vn/', 'contact@fpt.com', NULL, NULL, NULL, NULL),
(2, 'Ngân Hàng TMCP Việt Nam Thịnh Vượng (VPBank)', NULL, '89 Láng Hạ, Đống Đa, Hà Nội', 'VN', 1, 10000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/ngan-hang-tmcp-viet-nam-thinh-vuong-vpbank-63e1cb5539e62.jpg', 'https://www.vpbank.com.vn/', 'chamsockhachhang@vpbank.com.vn', NULL, NULL, NULL, NULL),
(3, 'Công Ty TNHH Bảo Hiểm Nhân Thọ AIA (Việt Nam)', NULL, 'Tòa nhà Petronas lầu 8, 235 Nguyễn Văn Cừ, p.Nguyễn Cư Trinh, Quận 1, TP HCM', 'VN', 79, 1000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-tnhh-bao-hiem-nhan-tho-aia-viet-nam-5fcefe44252e7.jpg', 'https://www.aia.com.vn/vi/index.html', 'mytrinhho2000@gmail.com', NULL, NULL, NULL, NULL),
(4, 'Công ty TNHH Concentrix Service Vietnam', NULL, 'Tầng 4, 6 và 7, QTSC Building 1, Lô 34, đường số 14, Công viên phần mềm Quang Trung, phường Tân Chánh Hiệp, Quận 12, Thành Phố Hồ Chí Minh, Việt Nam', 'US', 1, 1000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-tnhh-concentrix-service-vietnam-a963cac26074348bc95ce4bf90dc9fb1-6423dfbc43963.jpg', 'https://www.concentrix.com/', 'hr.anvu1122@gmail.com', NULL, NULL, NULL, NULL),
(5, 'Trung Tâm Anh Ngữ ILA', NULL, 'The Crest Residence, số 15, đường Trần Bạch Đằng, phường Thủ Thiêm, thành phố Thủ Đức, Thành phố Hồ Chí Minh.', 'VN', 79, 500, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/trung-tam-anh-ngu-ila-57bfa5cf4cf23_rs.jpg', 'https://www.ila.edu.vn/', 'vacancies@ilavietnam.edu.vn', NULL, NULL, NULL, NULL),
(6, 'Tổ chức Giáo dục quốc tế Langmaster', NULL, 'Tòa nhà 201 Cầu Giấy, Q.Cầu Giấy, Hà Nội', 'VN', 1, 400, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/95UMEz8Uvwsc56NdTRk47FFlBOBdPEmo_1689071248____d38d8958820f4415fa920481e68bbbee.jpg', 'https://langmaster.edu.vn/', 'info@binggo.edu.vn', NULL, NULL, NULL, NULL),
(7, 'Hệ thống Anh ngữ AMES', NULL, 'Hà Nội, Nam Định, Thái Nguyên, Hải Phòng, Hạ Long, Nghệ An, Thanh Hóa, Huế, Đà Nẵng, Quy Nhơn, Cần Thơ,Quảng Ninh, Hà Nam, Hưng Yên', 'VN', 1, 1000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/he-thong-anh-ngu-ames-5ce6414e090e0.jpg', 'jobs.ames.edu.vn', 'gopy@ames.edu.vn', NULL, NULL, NULL, NULL),
(8, 'FE CREDIT', NULL, 'Tầng trệt, 144 Cộng Hòa, P12, Q.Tân Bình, TP HCM.', 'VN', 79, 10000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/4309b044c7147d553222bc769da5161d-6194b4d027185.jpg', 'https://www.fecredit.com.vn/', 'dichvukhachhang@fecredit.com.vn', NULL, NULL, NULL, NULL),
(9, 'Công ty cổ phần Hạ tầng Viễn thông CMC Telecom', NULL, 'Tầng 11, Tòa nhà CMC, 11 đường Duy Tân, quận Cầu Giấy, Hà Nội', 'VN', 1, 500, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-co-phan-ha-tang-vien-thong-cmc-telecom-5af4f4a61b6e4_rs.jpg', 'https://cmctelecom.vn', 'cloud.ibu@cmctelecom.vn', NULL, NULL, NULL, NULL),
(10, 'NGÂN HÀNG THƯƠNG MẠI CỔ PHẦN KỸ THƯƠNG VIỆT NAM', NULL, 'Số 6 Quang Trung, phường Trần Hưng Đạo, Quận Hoàn Kiếm, Thành phố Hà Nội', 'VN', 1, 10000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/ngan-hang-thuong-mai-co-phan-ky-thuong-viet-nam-632bbf5a763f7.jpg', 'https://techcombankjobs.com/', 'call_center@techcombank.com.vn', NULL, NULL, NULL, NULL),
(11, 'Công ty Cổ phần viễn thông FPT', NULL, 'Tầng 2, tòa nhà FPT, Phố Duy Tân, Cầu Giấy, Hà Nội', 'VN', 1, 5000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-co-phan-vien-thong-fpt-5d5f5980e317c.jpg', 'https://fptjobs.com', 'vietbh.fpt@gmail.com', NULL, NULL, NULL, NULL),
(12, 'CÔNG TY TNHH MEDIASTEP SOFTWARE VIỆT NAM', NULL, '60A Trường Sơn, P2, Tân Bình, Tp. Hồ Chí Minh', 'VN', 79, 499, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-tnhh-mediastep-software-viet-nam-5e548733aa731.jpg', 'https://mediastep.com/', 'nguyen.tran.thao@mediastep.com', NULL, NULL, NULL, NULL),
(13, 'Công ty TNHH Khu Du Lịch Vịnh Thiên Đường (ALMA)', NULL, 'Tầng 15, tòa nhà Capital Tower, 109 Trần Hưng Đạo, Hà Nội, Việt Nam - Tầng 29, Tòa nhà Lim, Số 9-11 Tôn Đức Thắng, Quận 1, TP.HCM', 'VN', 79, 1000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-tnhh-khu-du-lich-vinh-thien-duong-alma-591a6f04eae05_rs.jpg', 'http://alma.vn/', 'alma@gmail.com', NULL, NULL, NULL, NULL),
(14, 'CÔNG TY TNHH GIẢI PHÁP KINH DOANH THẾ HỆ MỚI VNNG', NULL, 'Hà Nội', 'VN', 1, 500, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-tnhh-giai-phap-kinh-doanh-the-he-moi-vnng-640fe72f8540f.jpg', 'http://www.facebook.com/VNNGbyVNPAY', 'chaultb@vnpay.vn', NULL, NULL, NULL, NULL),
(15, 'Công ty Cổ phần Đầu tư và Phát triển du lịch Ravi', NULL, 'Tầng 5 Atermis Tower, 3 Lê Trọng Tấn, Thanh Xuân, Hà Nội', 'VN', 1, 250, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-co-phan-dau-tu-va-phat-trien-du-lich-ravi-63ecad7250fe9.jpg', 'https://ravi.vn/', 'res@ravi.vn', NULL, NULL, NULL, NULL),
(16, 'Ngân Hàng TMCP An Bình', NULL, 'Tầng 1,2,3 Tòa nhà Geleximco, số 36 Hoàng Cầu, Phường Ô Chợ Dừa, Quận Đống Đa, Thành Phố Hà Nội, Việt Nam', 'VN', 1, 5000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/ngan-hang-tmcp-an-binh-61d408f161bd6.jpg', 'https://www.abbank.vn/', 'dichvukhachhang@abbank.vn', NULL, NULL, NULL, NULL),
(17, 'CÔNG TY CỔ PHẦN SMILEE VIỆT NAM', NULL, 'Số 138 Trần Vỹ, Phường Mai Dịch, Quận Cầu Giấy, Thành phố Hà Nội, Việt Nam', 'VN', 1, 99, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/euZxwfgBI59pNYbvMJuZdKtrUjQ6mGGJ_1680946520____edac48ae2d867304dbbfd991932ac5c8.png', 'https://www.topcv.vn/cong-ty/cong-ty-co-phan-smilee-viet-nam/135823.html', 'customer.lover@smilee.vn', NULL, NULL, NULL, NULL),
(18, 'CÔNG TY TNHH TƯ VẤN & ĐÀO TẠO ĐẠI DƯƠNG', NULL, 'Số 25 Đường số 23, Phường Linh Chiểu, Quận Thủ Đức', 'VN', 79, 1000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/VcHGfKX477DToFxwKnJ9mW1v8YFhEhEk_1649920055____5107dabb0160776d57f4fdf975da7104.jpg', 'http://tinhocdaiduong.vn/vn/', 'daiduong.hr1@gmail.com', NULL, NULL, NULL, NULL),
(19, 'CÔNG TY TNHH ALIBABA.COM (VIỆT NAM)', NULL, 'Saigon Centre Tower 2, 67 Le Loi Street, Ben Nghe Ward, District 1, Ho Chi Minh City, Vietnam', 'CN', 79, 1000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-tnhh-alibabacom-viet-nam-c0bb32ea63e7bd3382cc1bcf7928be6c-64cb7c2f0c2d7.jpg', 'https://www.alibaba.com/', 'alibaba@gmail.com', NULL, NULL, NULL, NULL),
(20, 'CÔNG TY CỔ PHẦN BẤT ĐỘNG SẢN G.EMPIRE', NULL, 'Trụ sở chính: Tầng 3, Toà Handiresco Complex, 31 Lê Văn Lương, Hà Nội/ VP 2: Tầng 2, Toà 17T1 Hapulico Complex, 81 Vũ Trọng Phụng, Hà Nội', 'VN', 1, 99, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-co-phan-bat-dong-san-gempire-62908fae1a002.jpg', 'https://gempire.vn/', 'info@gempire.vn', NULL, NULL, NULL, NULL),
(21, 'CÔNG TY CỔ PHẦN EDUVATOR', NULL, 'Số nhà 65, phố Yên Lãng, Phường Trung Liệt, Quận Đống Đa, Thành phố Hà Nội, Việt Nam', 'VN', 1, 400, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-co-phan-eduvator-64213c06f3c25.jpg', 'https://zim.vn/', 'zim@gmail.com', NULL, NULL, NULL, NULL),
(22, 'Công ty TNHH TOTO Việt Nam', NULL, 'Lô F1 - KCN Thăng Long - Kim Chung - Đông Anh - Hà Nội', 'VN', 1, 200, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-tnhh-toto-viet-nam-5d9ab7dcbcb1f.jpg', 'https://vn.toto.com/', 'toto@gmail.com', NULL, NULL, NULL, NULL),
(23, 'CÔNG TY TNHH BÁNH KẸO TÂN THẾ KỶ', NULL, '548-550 nguyễn Trãi, Phường 8, Quận 5, Thành phố Hồ Chí Minh, Việt Nam', 'VN', 79, 99, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-tnhh-banh-keo-tan-the-ky-630d94845a581.jpg', 'https://www.topcv.vn/cong-ty/cong-ty-tnhh-banh-keo-tan-the-ky/117214.html', 'tantheki@gmail.com', NULL, NULL, NULL, NULL),
(24, 'CÔNG TY CỔ PHẦN CÔNG NGHỆ KIOTVIET', NULL, 'Tòa nhà Waseco, Khu C, Tầng 6 - Số 10, Phổ Quang, Phường 02, Quận Tân Bình, Thành phố Hồ Chí Minh', 'VN', 79, 499, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-co-phan-cong-nghe-kiotviet-64211ae60fe0e.jpg', 'https://www.kiotviet.vn/', 'jobs@kiotviet.com', NULL, NULL, NULL, NULL),
(25, 'Công ty Cổ phần Tập đoàn TH', NULL, 'Xóm Sơn Liên - Xã Nghĩa Sơn - huyện Nghĩa Đàn - tỉnh Nghệ An', 'VN', 40, 10000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/vvLBunkWTv4pwHAizzlb0NFg8fKT1DmZ_1675680776____6e0657f4e4e07108dffa7c94cb781dfa.jpg', 'https://thgroupglobal.com/', 'thgroupglobal@gmail.com', NULL, NULL, NULL, NULL),
(26, 'Công ty TNHH Lotte Việt Nam', NULL, 'Tòa báo Tuổi trẻ, Lầu 4, 60A Hoàng Văn Thụ, Phường 9, Quận Phú Nhuận, HCM', 'VN', 79, 1000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-tnhh-lotte-viet-nam-63a15c6fdb99a.jpg', 'https://lotte.com.vn/', 'sales_hcm@lotte.com.vn', NULL, NULL, NULL, NULL),
(27, 'Công ty Cổ phần Giáo dục & Đào tạo IMAP Việt Nam', NULL, '14 Trần Kim Xuyến, Phường Yên Hoà, Quận Cầu Giấy, Thành phố Hà Nội, Việt Nam', 'VN', 1, 1000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-co-phan-giao-duc-dao-tao-imap-viet-nam-5da97e1f22484.jpg', 'https://imap.edu.vn', 'phongtuyendung@imap.edu.vn', NULL, NULL, NULL, NULL),
(28, 'CÔNG TY TNHH BẢO HIỂM HANWHALIFE VIỆT NAM', NULL, '63 Phan Đăng Lưu, Hòa Cường Bắc, Hải Châu, Đà Nẵng', 'KR', 48, 499, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/53681e711f1aba09def2c2be6d5ed51a-6181f90ec0555.jpg', 'https://www.hanwhalife.com.vn/vi', 'customer.service@hanwhalife.com.vn', NULL, NULL, NULL, NULL),
(29, 'Ngân Hàng Bảo Việt', NULL, '16 Phan Chu Trinh, Hoàn Kiếm, Hà Nội', 'VN', 1, 1000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/ngan-hang-bao-viet-5937b34d972ad_rs.jpg', 'https://www.baovietbank.vn/', 'callcenter@baovietbank.vn', NULL, NULL, NULL, NULL),
(30, 'Ngân Hàng Thương Mại Cổ Phần Quốc Tế Việt Nam', NULL, 'Tầng 1, (Tầng trệt) và Tầng 2 Tòa nhà Sailing Tower, số 111A Pasteur, Phường Bến Nghé, Quận 1, Hồ Chí Minh', 'VN', 79, 10000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/beac8465d62ef14e651a81e546dd9986-5fe1a719810ff.jpg', 'https://careers.vib.com.vn/careers', 'dvkh247@vib.com.vn', NULL, NULL, NULL, NULL),
(31, 'Bệnh Viện Đa Khoa Quốc Tế Thu Cúc - Chi Nhánh Công Ty Cổ Phần Y Khoa & Thẩm Mỹ Thu Cúc', NULL, 'Trụ sở chính: 444 Hoàng Hoa Thám, Tây Hồ, Hà Nội', 'VN', 1, 1000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/benh-vien-da-khoa-quoc-te-thu-cuc-chi-nhanh-cong-ty-co-phan-y-khoa-amp-tham-my-thu-cuc-793fe6bf448001cb13596b014cd7ecb5-650416fca81e5.jpg', 'https://thucuchospital.com/', 'contact@thucuchospital.vn', NULL, NULL, NULL, NULL),
(32, 'Tổ chức Giáo dục và Đào tạo Apollo Việt Nam', NULL, 'Số 181 Phố Huế, Hai Bà Trưng, Hà Nội', 'VN', 1, 1000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/to-chuc-giao-duc-va-dao-tao-apollo-viet-nam-5dd4bce9c2fa0.jpg', 'http://apollo.edu.vn/', 'talk2us@apollo.edu.vn', NULL, NULL, NULL, NULL),
(33, 'UNIQLO VIETNAM CO., LTD.', NULL, 'Tầng 26, Tòa nhà Trụ Sở Điều Hành Và Trung Tâm Thương Mại Viettel, 285 Cách Mạng Tháng Tám, Phường 12, Quận 10, Thành phố Hồ Chí Minh, Việt Nam', 'JP', 79, 1000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/6vJFmQJvgOOyaD53GYE86sgHxmlfHVAC_1695628300____5c565acefcad36149cfb1baf6ea0c512.png', 'https://www.uniqlo.com/vn/vi/', 'uniqlo@gmail.com', NULL, NULL, NULL, NULL),
(34, 'CÔNG TY TNHH ALI LOGISTICS VIỆT NAM', NULL, '168 TRUNG KINH_ CẦU GIẤY_ HÀ NỘI', 'VN', 1, 300, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-tnhh-ali-logistics-viet-nam-574ffa0271be33492bc658bd38a8068c-66232e161f9ee.jpg', 'https://orderthangloi.com/', 'cskh.orderthangloi@gmail.com', NULL, NULL, NULL, NULL),
(35, 'CÔNG TY TNHH BẢO TÍN MINH CHÂU', NULL, 'Số 29 Trần Nhân Tông, Phường Nguyễn Du, Quận Hai Bà Trưng, Thành phố Hà Nội, Việt Nam', 'VN', 1, 10000, NULL, 'https://cdn-new.topcv.vn/unsafe/140x/https://static.topcv.vn/company_logos/cong-ty-tnhh-bao-tin-minh-chau-509d9df8c3bcab4171712bfacdf4b8cd-65a4fa0a9772f.jpg', 'https://btmc.vn/', 'cskh@btmc.vn', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `expect_jobs`
--

CREATE TABLE `expect_jobs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `min_salary` bigint(20) DEFAULT NULL,
  `industries` varchar(255) NOT NULL,
  `working_experience` int(11) DEFAULT 0,
  `working_method` enum('offline','remote','hybrid') DEFAULT NULL,
  `working_type` enum('fulltime','partime') DEFAULT 'fulltime',
  `province_id` int(11) NOT NULL,
  `skills` text DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `industries`
--

CREATE TABLE `industries` (
  `id` int(11) NOT NULL,
  `industry` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `industries`
--

INSERT INTO `industries` (`id`, `industry`, `createdAt`, `updatedAt`) VALUES
(1, 'Công nghệ thông tin', '2024-05-22 05:46:38', '2024-05-22 05:46:38'),
(2, 'Hoạch định/Dự án', '2024-05-22 05:46:38', '2024-05-22 05:46:38'),
(3, 'IT phần mềm', '2024-05-22 05:48:55', '2024-05-22 05:48:55'),
(4, 'Việc làm IT', '2024-05-22 05:48:55', '2024-05-22 05:48:55'),
(5, 'Kinh doanh / Bán hàng', '2024-05-22 05:50:44', '2024-05-22 05:50:44'),
(6, 'Luật/Pháp lý', '2024-05-22 06:02:03', '2024-05-22 06:02:03'),
(7, 'Ngân hàng / Tài chính', '2024-05-22 06:02:03', '2024-05-22 06:02:03'),
(8, 'Bất động sản', '2024-05-22 06:02:03', '2024-05-22 06:02:03'),
(9, 'Tài chính / Đầu tư', '2024-05-22 06:03:09', '2024-05-22 06:03:09'),
(10, 'Bảo hiểm', '2024-05-22 06:12:11', '2024-05-22 06:12:11'),
(11, 'Dịch vụ khách hàng', '2024-05-22 06:13:27', '2024-05-22 06:13:27'),
(12, 'Hành chính / Văn phòng', '2024-05-22 06:13:27', '2024-05-22 06:13:27'),
(13, 'Marketing / Truyền thông / Quảng cáo', '2024-05-22 06:14:44', '2024-05-22 06:14:44'),
(14, 'IT Phần cứng / Mạng', '2024-05-22 06:16:45', '2024-05-22 06:16:45');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `min_salary` bigint(20) NOT NULL,
  `max_salary` bigint(20) NOT NULL,
  `recruitment_number` int(11) NOT NULL,
  `working_experience` int(11) DEFAULT 0,
  `working_method` enum('offline','remote','hybrid') DEFAULT 'offline',
  `working_type` enum('fulltime','partime') NOT NULL DEFAULT 'fulltime',
  `expired_date` datetime DEFAULT NULL,
  `start_week_day` int(11) DEFAULT 2,
  `end_week_day` int(11) DEFAULT 6,
  `degree` enum('Thực tập sinh','Nhân viên','Trưởng nhóm','Giám đốc','Tổng giám đốc') DEFAULT 'Nhân viên',
  `gender` enum('male','female') DEFAULT NULL,
  `province_id` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `company_id`, `title`, `description`, `min_salary`, `max_salary`, `recruitment_number`, `working_experience`, `working_method`, `working_type`, `expired_date`, `start_week_day`, `end_week_day`, `degree`, `gender`, `province_id`, `createdAt`, `updatedAt`) VALUES
(1, 1, 'Cán Bộ Triển Khai Phần Mềm Dịch Vụ', '<h3>Mô tả công việc</h3><ul><li>Tư vấn, triển khai, cài đặt hệ thống phần mềm cho các Dự án về nhân sự tiền lương cho Doanh nghiệp</li><li>Giới thiệu, hướng dẫn và hỗ trợ sử dụng phần mềm sau khi triển khai</li><li>Kiểm tra phần mềm, đảm bảo chất lượng hệ thống khi triển khai.</li><li>Đào tạo hướng dẫn khách hàng sử dụng phần mềm của công ty.</li><li>Hỗ trợ khách hàng trực tiếp, tận nơi, khi khách hàng có gặp khó khăn trong việc vận hành</li><li>phần mềm triển khai dự án</li><li>Báo cáo cho Ban Lãnh đạo dự án theo quy định</li><li>Đề xuất phương án tổ chức, quản lý dự án hiệu quả</li></ul><h3>Yêu cầu ứng viên</h3><ul><li>Tốt nghiệp CĐ/ĐH chuyên ngành CNTT hoặc có liên quan</li><li>Có từ 2 năm kinh nghiệm triển khai phần mềm</li><li>Ưu tiên có hiểu biết về nghiệp vụ nhân sự</li><li>Có kiến thức cơ bản về cơ sở dữ liệu SQL Server</li><li>Kỹ năng giao tiếp tốt, năng động, phân tích đàm phán, giải quyết vấn đề tốt.</li><li>Có khả năng làm việc độc lập và làm việc theo nhóm</li><li>Có khả năng chịu áp lực công việc</li><li>Có kỹ năng giao tiếp, trình bày và lắng nghe</li></ul><h3>Quyền lợi</h3><ul><li>Mức lương hấp dẫn, thỏa thuận theo năng lực.</li><li>Thời gian làm việc từ Thứ 2 đến Thứ 6.</li><li>Được tham gia các khóa đào tạo kỹ năng và nghiệp vụ nâng cao;</li><li>15 ngày phép/năm và các ngày nghỉ Lễ theo quy định;</li><li>Lương tháng 13 và thưởng KPI;</li><li>Xem xét tăng lương hàng năm;</li><li>Bảo hiểm FPTCare cho bản thân và cơ hội mua FPTCare cho gia đình;</li><li>Khám sức khoẻ định kỳ;</li><li>Các hoạt động teambuilding, nghỉ mát hàng năm; các hoạt động văn hoá, sự kiện hấp dẫn</li><li>của Công ty FPT IS và Tập đoàn FPT.</li></ul><h3>Địa điểm làm việc</h3><p>- Hà Nội: Tòa nhà Keangnam Landmark 72, E6 Phạm Hùng, Nam Từ Liêm</p><h3>Thời gian làm việc</h3><p>Thứ 2 - Thứ 6 (từ 08:00 đến 18:30)</p><p><br></p>', 10000000, 20000000, 3, 0, 'offline', 'fulltime', '2024-06-06 00:00:00', 2, 7, 'Nhân viên', 'male', 1, '2024-05-22 05:46:38', '2024-05-22 05:46:38'),
(2, 1, 'Kỹ Sư Dữ Liệu', '<h3>Mô tả công việc</h3><ul><li>Analyze and understand existing ETL jobs developed in IBM DataStage.</li><li>Design and develop equivalent ETL workflows in Oracle Data Integrator (ODI).</li><li>Utilize ODI features for data extraction, transformation, and loading processes, ensuring data quality and integrity.</li><li>Collaborate with business analysts and data architects to understand data requirements and mapping needs.</li><li>Develop unit tests and implement a testing strategy for migrated ETL jobs.</li><li>Document the migration process and create detailed technical specifications for migrated workflows</li></ul><h3>Yêu cầu ứng viên</h3><ul><li>Working experience with IBM DataStage, Oracle Data Integrator (ODI) and its key functionalities.</li><li>Strong SQL programming skills (T-SQL, PL/SQL preferred).</li><li>Have at least 03 years of data installation experience, become the data processing tool of choice OCB</li><li>Experience in developing Data Warehouse, Data Lake projects, and similar data conversion projects is an advantage</li><li>Development personnel must achieve minimum evidence of:</li><li>Oracle Database Administrator / Cloud Database Administrator</li><li>Oracle Data Integration (ETL) Certification</li></ul><h3>Quyền lợi</h3><ul><li>Attractive salary package with 13th and performance bonus</li><li>Opportunity to work and R&amp;D disruptive technologies</li><li>Opportunity to work in a professional, modern and dynamic environment</li><li>Opportunity to obtain oversea and on-job training or external training for Professional Certificate</li><li>Good corporate culture with in/out of office activities that help to develop candidate’s ability and creativity</li><li>FPT health care and social insurance</li><li>Participation in sponsored sports clubs of football, badminton, yoga, dancing, racing...</li></ul><p><br></p>', 20000000, 30000000, 2, 3, 'offline', 'fulltime', '2024-06-08 00:00:00', 2, 6, 'Nhân viên', 'male', 1, '2024-05-22 05:48:55', '2024-05-22 05:48:55'),
(3, 1, 'Cán Bộ Phát Triển Kinh Doanh – Khối Doanh Nghiệp', '<h3>Mô tả công việc</h3><ul><li>Tìm hiểu, nghiên cứu về các sản phẩm công nghệ của công ty để giới thiệu, tư vấn và giải đáp thắc mắc cho khách hàng.</li><li>Đàm phán, thương lượng với khách hàng về giá cả, hợp đồng, tiến hành chốt đơn và hỗ trợ khách hàng ký hợp đồng.</li><li>Chăm sóc khách hàng sau khi bán hàng, duy trì mối quan hệ với khách hàng hiện tại.</li><li>Tìm kiến nguồn khách hàng mới, xây dựng data, mở rộng phát triển quan hệ.</li><li>Thực hiện các công việc khác theo sự phân công của cấp trên.</li></ul><h3>Yêu cầu ứng viên</h3><ul><li>Tốt nghiệp chuyên ngành Kinh tế, Quản trị kinh doanh, Kỹ thuật ...</li><li>Đam mê công nghệ, Có kinh nghiệm kinh doanh là một lợi thế.</li><li>Chủ động, nhiệt tình, chịu khó trong công việc</li><li>Chấp nhận đi công tác tỉnh, mở rộng thị trường.</li><li>Khả năng giao tiếp, xây dựng quan hệ</li><li>Thành thạo tin học văn phòng</li><li>Giao tiếp Tiếng anh thành thạo, ưu tiên biết tiếng Trung.</li></ul><h3>Quyền lợi</h3><ul><li>Mức lương hấp dẫn, thỏa thuận theo năng lực. Lương tháng 13 và thưởng KPI.</li><li>Thời gian làm việc từ Thứ 2 đến Thứ 6.</li><li>Được tham gia các khóa đào tạo kỹ năng và nghiệp vụ nâng cao;</li><li>15 ngày phép/năm và các ngày nghỉ Lễ theo quy định;</li><li>Xem xét tăng lương hàng năm;</li><li>Bảo hiểm FPTCare cho bản thân và cơ hội mua FPTCare cho gia đình;</li><li>Khám sức khoẻ định kỳ;</li><li>Các hoạt động teambuilding, nghỉ mát hàng năm; các hoạt động văn hoá, sự kiện hấp dẫn của Công ty FPT IS và Tập đoàn FPT.</li></ul><h3>Địa điểm làm việc</h3><p>- Hà Nội: • Tầng 22 tòa nhà Keangnam Landmark 72, E6 Phạm Hùng, Từ Liêm</p><h3>Thời gian làm việc</h3><p>Thứ 2 - Thứ 6 (từ 08:30 đến 17:30)</p>', 8000000, 15000000, 2, 0, 'hybrid', 'fulltime', '2024-06-03 00:00:00', 2, 6, 'Nhân viên', 'male', 1, '2024-05-22 05:50:44', '2024-05-22 05:50:44'),
(4, 1, 'Nhân Viên Quản Lý Nguồn Quỹ Đối Tác Quốc Tế', '<h3>Mô tả công việc</h3><ul><li>Thu thập, xử lý, chuẩn bị file báo cáo dữ liệu theo yêu cầu từ hãng cung cấp;</li><li>Quản lý các quỹ, nguồn tài trợ từ những hãng đối tác dành cho Công ty.</li><li>Nắm bắt, theo dõi tiến độ các chương trình hỗ trợ từ hãng dành cho Công ty;</li><li>Theo dõi thanh toán các khoản hỗ trợ, phối hợp với kế toán để thực hiện phân bổ/hạch toán theo quy định.</li><li>Thực hiện các nhiệm vụ khác theo phân công của Trưởng ban Quản lý đối tác và hỗ trợ kinh doanh.</li></ul><h3>Yêu cầu ứng viên</h3><ul><li>Tốt nghiệp Đại học chuyên ngành Kiểm toán, kinh tế, ngoại thương, tài chính;</li><li>Có tư duy phân tích, tổng hợp số liệu;</li><li>Thành thạo kỹ năng tin học văn phòng (đặc biệt Excel);</li><li>Tiếng Anh tốt: Ielts 7 trở lên;</li><li>Có trách nhiệm, chịu được áp lực cao trong công việc;</li><li>Kinh nghiệm: 0-8 năm;</li><li>Ưu tiên có kinh nghiệm làm kiểm toán ở Big4: KPMG, E&amp;Y, PWC, Deloitte</li></ul><h3>Quyền lợi</h3><ul><li>Thu nhập cạnh tranh, lương tháng 13 rõ ràng, thưởng theo hiệu quả công việc</li><li>Được hỗ trợ chi phí học tập và thi các khóa học/chứng chỉ cần thiết cho công việc</li><li>Các hoạt động phong trào, văn hóa đoàn thể đậm chất văn hóa FPT</li><li>Môi trường làm việc thân thiện, cởi mở, trẻ trung.</li><li>Được hưởng đầy đủ các chế độ theo luật Lao động hiện hành</li><li>Chính sách phúc lợi toàn diện theo quy định của Công ty: Chế độ tham quan, nghỉ mát; Khám sức khỏe định kì hàng năm; Chế độ chăm sóc sức khỏe đặc biệt (Bảo hiểm FPT Care)</li><li>Đặc biệt: chính sách hỗ trợ mua máy tính cá nhân dành riêng cho CBNV chính thức của FPT IS.</li></ul><h3>Địa điểm làm việc</h3><p>- Hà Nội: Tầng 22, tòa nhà Keangnam Landmark 72, E6 Phạm Hùng, Nam Từ Liêm</p><h3>Thời gian làm việc</h3><p>Thứ 2 - Thứ 6 (từ 08:30 đến 17:30)</p>', 23000000, 25000000, 4, 0, 'offline', 'fulltime', '2024-06-07 00:00:00', 2, 6, 'Nhân viên', 'female', 1, '2024-05-22 05:52:17', '2024-05-22 05:52:17'),
(5, 1, 'Data Engineer (Junior/ Senior)', '<h3>Mô tả công việc</h3><ul><li>Analyze and understand existing ETL jobs developed in IBM DataStage.</li><li>Design and develop equivalent ETL workflows in Oracle Data Integrator (ODI).</li><li>Utilize ODI features for data extraction, transformation, and loading processes, ensuring data quality and integrity.</li><li>Collaborate with business analysts and data architects to understand data requirements and mapping needs.</li><li>Develop unit tests and implement a testing strategy for migrated ETL jobs.</li><li>Document the migration process and create detailed technical specifications for migrated workflows</li></ul><h3>Yêu cầu ứng viên</h3><ul><li>Working experience with IBM DataStage, Oracle Data Integrator (ODI) and its key functionalities.</li><li>Strong SQL programming skills (T-SQL, PL/SQL preferred).</li><li>Have at least 03 years of data installation experience, become the data processing tool of choice OCB</li><li>Experience in developing Data Warehouse, Data Lake projects, and similar data conversion projects is an advantage</li><li>Development personnel must achieve minimum evidence of:</li><li>Oracle Database Administrator / Cloud Database Administrator</li><li>Oracle Data Integration (ETL) Certification</li></ul><h3>Quyền lợi</h3><ul><li>Attractive salary package with 13th and performance bonus</li><li>Opportunity to work and R&amp;D disruptive technologies</li><li>Opportunity to work in a professional, modern and dynamic environment</li><li>Opportunity to obtain oversea and on-job training or external training for Professional Certificate</li><li>Good corporate culture with in/out of office activities that help to develop candidate’s ability and creativity</li><li>FPT health care and social insurance</li><li>Participation in sponsored sports clubs of football, badminton, yoga, dancing, racing...</li></ul><h3>Địa điểm làm việc</h3><p>- Hà Nội: Tầng 22, Keangnam Landmark 72, Phạm Hùng, Nam Từ Liêm, Nam Từ Liêm</p><h3>Thời gian làm việc</h3><p>Thứ 2 - Thứ 6 (từ 00:00 đến 00:00)</p><p><br></p>', 15000000, 25000000, 4, 2, 'offline', 'fulltime', '2024-06-07 00:00:00', 2, 6, 'Nhân viên', 'male', 1, '2024-05-22 05:54:02', '2024-05-22 05:54:02'),
(6, 2, 'Chuyên Viên Xử Lý Tài Sản Đảm Bảo - Hà Nội', '<h3>Mô tả công việc</h3><p>1. Chuẩn bị hồ sơ tài sản, hồ sơ khách hàng trước bán:</p><p>- Thu thập thông tin liên quan đến tài sản cần xử lý: Khách hàng vay, chủ tài sản, tài sản, khoản vay, dư nợ, chấp hành viên, các vướng mắc liên quan ...;</p><p>- Tiến hành khảo sát hiện trạng tài sản, đối chiếu hồ sơ và hiện trạng để đề xuất phương án bán/hỗ trợ bán tài sản để hỗ trợ công tác thu nợ;</p><p>2. Bán tài sản</p><p><em>2.1. Bán TSTC theo hình thức thỏa thuận:</em></p><p>- Liên hệ gặp gỡ chủ tài sản/người liên quan ... để ghi nhận, trao đổi các thủ tục và giá mua, bán tài sản</p><p>- Truyền thông, đăng tin, tìm kiếm khách hàng, tele-sale để tìm kiếm khách hàng mua tài sản, lọc danh sách tài sản gửi các đối tác đầu tư, môi giới trong lĩnh vực liên quan;</p><p><em>2.2. Xử lý/bán TSTC do VPBank thu giữ/nhận bàn giao theo quy định pháp luật theo hình thức VPBank đấu giá:</em></p><p>- Tiếp nhận yêu cầu và nhận bàn giao hồ sơ tài sản cần bán đấu giá của các đơn vị Xử lý nợ do Đơn vị có chức năng phân luồng để thực hiện việc phát mại tài sản đối với các tài sản VPBank thu giữ/nhận bàn giao theo quy định pháp luật;</p><p>- Gửi hồ sơ yêu cầu định giá nội bộ, thuê định giá độc lập và dẫn cán bộ định giá khảo sát hiện trạng tài sản.</p><p>- Phối hợp với đơn vị đấu giá để thực hiện các thủ tục triển khai đấu giá tài sản và thông báo tới các bên liên quan.</p><p>- Truyền thông, đăng tin, tìm kiếm khách hàng, tele-sale để tìm kiếm khách hàng mua tài sản, lọc danh sách tài sản gửi các đối tác đầu tư, môi giới trong lĩnh vực liên quan.</p><p>- Dưới sự hướng dẫn và hỗ trợ của Trưởng Bộ phận hoặc Chuyên viên chính XLTSBĐ BĐS, dẫn khách hàng đi xem tài sản, tư vấn, hướng dẫn các thủ tục mua hồ sơ, nộp cọc tham gia đấu giá;</p><p>3. Các thủ tục sau bán:</p><p>- Cập nhật thông tin quá trình xử lý tài sản bán đầy đủ lên hệ thống theo quy định;</p><p>- Lưu trữ hồ sơ đầy đủ, khoa học theo checklist;</p><p>4. Các công việc khác và theo chỉ đạo của cấp trên:</p><p>- Thực hiện chế độ báo cáo định kỳ và báo cáo tác nghiệp lên phần mềm Tethys</p><p>- Các công việc khác theo chỉ đạo của cấp trên</p><p>- Thực hiện các sáng kiến &amp; công việc để nâng cao trải nghiệm khách hàng</p><h3>Yêu cầu ứng viên</h3><p>1. Trình độ Học vấn: Trung cấp, Cao đẳng</p><p>2. Kiến thức/ Chuyên môn Có Liên Quan</p><ul><li>Sale &amp; Marketing</li><li>- Hiểu biết sơ bộ về tài sản bảo đảm và các sản phẩm thành phần;</li></ul><p>3. Các Kỹ Năng/ Skills</p><ul><li>Kỹ năng quản lý thời gian;</li><li>Kỹ năng lập kế hoạch và tổ chức thực hiện</li><li>Kỹ năng quản lý kết quả công việc;</li><li>Kỹ năng đàm phán và thương lượng;</li></ul><p>4. Các Kinh nghiệm Liên quan/ Relevant Experience</p><ul><li>06 tháng kinh nghiệm vị trí nhân viên kinh doanh</li><li>Có kinh nghiệm triển khai Marketing online</li></ul><p>5. Các yêu cầu khác/ Others</p><ul><li>Trung thực;</li><li>Hợp tác</li><li>Chủ động sáng tạo</li><li>Tự tin</li><li>Kiên nhẫn</li></ul><h3>Quyền lợi</h3><ul><li>Thu nhập hấp dẫn, lương thưởng cạnh tranh theo năng lực</li><li>Thưởng các Ngày lễ, Tết (theo chính sách ngân hàng từng thời kỳ)</li><li>Được vay ưu đãi theo chính sách ngân hàng từng thời kỳ</li><li>Chế độ ngày phép hấp dẫn theo cấp bậc công việc</li><li>Bảo hiểm bắt buộc theo luật lao động + Bảo hiểm VPBank care cho CBNV tùy theo cấp bậc và thời gian công tác</li><li>Được tham gia các khóa đào tạo tùy thuộc vào Khung đào tạo cho từng vị trí</li><li>Thời gian làm việc: từ thứ 2 – thứ 6 &amp; 02 sáng thứ 7/ tháng</li><li>Môi trường làm việc năng động, thân thiện, có nhiều cơ hội học đào tạo, học hỏi và phát triển; được tham gia nhiều hoạt động văn hóa thú vị (cuộc thi về thể thao, tài năng, hoạt động teambuiding...)</li></ul><h3>Địa điểm làm việc</h3><p>- Hà Nội</p>', 10000000, 15000000, 1, 1, 'offline', 'fulltime', '2024-05-30 00:00:00', 2, 6, 'Nhân viên', 'female', 1, '2024-05-22 06:02:03', '2024-05-22 06:02:03'),
(7, 2, 'Chuyên Viên Cao Cấp Rủi Ro Hoạt Động - Hà Nội ', '<h3>Mô tả công việc</h3><p>Nhận diện, đánh giá, quản lý rủi ro hoạt động trong ngân hàng qua các công cụ quản lý rủi ro hoạt động như: Thu thập sự kiện tổn thất; Chi số rủi ro chính; Tự đánh giá rủi ro và chốt kiểm soát; Rà soát Quy trình/Quy định;... nhằm nhận diện/phát hiện sớm các rủi ro và có những giải pháp phù hợp để giảm thiểu tổn thất phát sinh cho ngân hàng.</p><p>1. Triển khai công cụ Thu thập và phân tích sự kiện RRHĐ nhằm giúp sự kiện RRHĐ được ghi nhận đầy đủ, chinh xác các thông tin theo quy định</p><p>2. Triển khai công cụ Chỉ số rủi ro chính với kết quả cần đạt được là các chỉ số có đầy đủ thông tin, cách thức tính, ghi nhận dữ liệu, nguồn dữ liệu và các phân tích với các chỉ số của từng tháng phát sinh</p><p>3. Triển khai công cụ Tự đánh giá rủi ro và chốt kiểm soát nhằm xác định các rủi ro trọng yếu và các giải pháp đã được thống nhất và phê duyệt bởi các GĐK. Theo dõi việc hoàn thành các giải pháp của các rủi ro trọng yếu nhằm đảm bảo các rủi ro trọng yếu được hoàn thành theo kế hoạch đã phê duyệt</p><p>4. Rà soát, góp ý với các quy định, quy trình, sản phẩm mới</p><p>5. Quản lý hoạt động rủi ro hoạt động thuê ngoài: Tham gia góp ý với hoạt động thuê ngoài kể từ khi có ý tưởng, thiết lập quan hệ (hợp đồng), theo dõi quá trình triển khai, thu thập các sự kiện RRHĐ liên quan đến hoạt động thuê ngoài</p><p>6. Các phát hiện, sáng kiến nâng cao hiệu quả quản lý rủi ro hoạt động trong ngân hàng nhằm góp phần giảm thiểu các tổn thất có thể xảy ra</p><p>7. Đào tạo, truyền thông về rủi ro hoạt động tới các ĐPV, cán bộ nhân viên trong ngân hàng</p><h3>Yêu cầu ứng viên</h3><p>1. Tốt nghiệp Đại học chuyên ngành Kinh tế, Ngân hàng, Tài chính, Kế toán, Kiểm toán hoặc tương đương</p><p>2. Từ 2 - 5 năm kinh nghiệm tại các vị trí: Rủi ro hoạt động, rủi ro tuân thủ tại Ngân hàng, Công ty Tài chính, Công ty kiểm toán</p><p>3. Có khả năng tự nhận diện rủi ro tốt, phân tích nguyên nhân gốc rễ và đưa ra được các khuyến nghị giảm thiểu rủi ro mang tính chất thực tiễn cao</p><p>4. Tiếng Anh khá</p><p>5. Kỹ năng: làm việc nhóm; thuyết trình và giao tiếp tốt; phân tích và tư duy logic; chịu áp lực công việc cao, thành thạo tin học văn phòng, hệ điều hành Window</p><h3>Quyền lợi</h3><p>1. Thu nhập hấp dẫn, lương thưởng cạnh tranh theo năng lực</p><p>2. Thưởng các Ngày lễ, Tết (theo chính sách ngân hàng từng thời kỳ)</p><p>3. Được vay ưu đãi theo chính sách ngân hàng từng thời kỳ</p><p>4. Chế độ ngày phép hấp dẫn theo cấp bậc công việc</p><p>5. Bảo hiểm bắt buộc theo luật lao động + Bảo hiểm VPBank care cho CBNV tùy theo cấp bậc và thời gian công tác</p><p>6. Được tham gia các khóa đào tạo tùy thuộc vào Khung đào tạo cho từng vị trí</p><p>7. Môi trường làm việc năng động, thân thiện, có nhiều cơ hội học đào tạo, học hỏi và phát triển; được tham gia nhiều hoạt động văn hóa thú vị (cuộc thi về thể thao, tài năng, hoạt động teambuiding...)</p><h3>Địa điểm làm việc</h3><p>- Hà Nội</p>', 10000000, 16000000, 2, 2, 'offline', 'fulltime', '2024-05-26 00:00:00', 2, 6, 'Nhân viên', 'female', 1, '2024-05-22 06:03:09', '2024-05-22 06:03:09'),
(8, 2, 'Chuyên Viên Cao Cấp Quản Trị Dữ Liệu (BA Financial Data) - Hà Nội ', '<h3>Mô tả công việc</h3><p><strong>1. Kiểm soát chất lượng dữ liệu, báo cáo:</strong></p><p>- Xây dựng và tham gia phát triển các chốt kiểm soát dữ liệu nội tại hệ thống dữ liệu phòng đang quản lý;</p><p>- Kiểm soát chất lượng dữ liệu / báo cáo hàng ngày.</p><p><strong>2. Công tác phát triển:</strong></p><p>- Thu thập và phân tích yêu cầu, hoàn thiện tài liệu phân tích, SIT và đôn đốc việc hoàn thành UAT của nghiệp vụ cho các yêu cầu phòng Quản trị dữ liệu tài chính thực hiện phát triển;</p><p>- Xây dựng BRD và UAT cho các yêu cầu của phòng được khối CNTT và khối dữ liệu phát triển.</p><p>3.&nbsp;<strong>Tư vấn, hỗ trợ</strong>: Tư vấn, hỗ trợ các đơn vị trong khối Tài chính về giải pháp liên quan đến việc khai thác dữ liệu / báo cáo và tự động hóa quy trình nghiệp vụ.</p><p><strong>4. Quản lý yêu cầu phát triển của khối</strong>:</p><p>- Tiếp nhận và tổng hợp yêu cầu phát triển về bảng dữ liệu, báo cáo, sản phẩm dịch vụ CNTT từ các phòng ban trong Khối Tài chính;</p><p>- Phối hợp với khối CNTT và khối dữ liệu trong quá trình ước tính nguồn lực, cập nhật tiến độ phát triển, đầu mối phối hợp cùng nghiệp vụ đôn đốc khối CNTT và khối dữ liệu đáp ứng yêu cầu của nghiệp vụ;</p><p>5.&nbsp;<strong>Dự án</strong>: Tham gia các dự án của khối Tài chính và của Ngân hàng có liên quan đến dữ liệu và báo cáo tài chính: Tham gia xây dựng BRD và UAT yêu cầu phòng phụ trách, kiểm soát tiến độ xử lý các lỗi phát sinh;</p><p>6.&nbsp;<strong>Phát triển con người</strong>: Tham gia đào tạo, chia sẻ nội bộ phòng và khối; phối hợp với các thành viên trong phòng thực hiện tài liệu hóa kiến thức và liên tục cập nhật tài liệu để chia sẻ cho các thành viên mới của phòng và khối.</p><p>7. Đưa ra các đề xuất nhằm nâng cao hiệu quả công việc. Thực hiện các công việc khác theo sự phân công của Trưởng phòng.</p><h3>Yêu cầu ứng viên</h3><p><strong>1. Trình độ đào tạo</strong>: Trình độ chuyên môn: Tốt nghiệp Đại học trở lên chuyên ngành Kinh tế, Ngân hàng, Kế toán...</p><p><strong>2. Kiến thức/ Chuyên môn có liên quan</strong></p><p>- Am hiểu hoạt động kinh doanh và các sản phẩm dịch vụ của ngân hàng;</p><p>- Am hiểu các quy định của pháp luật và NHNN trong lĩnh vực ngân hàng, đầu tư tài chính;</p><p>- Có kiến thức sâu về ngân hàng, hoạt động tài chính, phân tích kinh doanh, phân tích tài chính, thị trường vốn, trao đổi tiền tệ, kế toán quản trị, hệ thống thông tin và cơ sở dữ liệu của ngân hàng ...</p><p><strong>3. Các kỹ năng</strong></p><p>- Trình độ Tin học: thành thạo tin văn phòng</p><p>- Trình độ ngoại ngữ (Tiếng Anh): giao tiếp thành thạo</p><p><strong>4. Các kinh nghiệm liên quan</strong></p><p>- Kinh nghiệm: Có ít nhất 6 - 8 năm kinh nghiệm làm việc tài chính, ngân hàng, phân tích nghiệp vụ...</p><p>- Ưu tiên có kinh nghiệm làm việc về kiểm toán, kế toán tổng hợp, thông tin báo cáo, kế hoạch ngân sách, phân tích kinh doanh, tài chính trong hệ thống ngân hàng.</p><p><strong>5. Các năng lực cần có</strong></p><p>- Khả năng nắm bắt công việc nhanh, quản lý, sắp xếp, xử lý công việc khoa học</p><p>- Thành thạo các phần mềm tính toán, phân tích số liệu và có khả năng làm việc tốt với số liệu</p><p>- Kỹ năng tổng hợp, trình bày báo cáo tốt; phân tích, tư vấn tốt về cơ chế ghi nhận kết quả kinh doanh, các chiều phân tích dữ liệu, ...</p><p>- Khả năng làm việc độc lập, phối hợp làm việc nhóm tốt</p><p>- Khả năng giao tiếp tốt</p><p>- Có khả năng hoạch định công việc, có tinh thần trách nhiệm cao trong công việc</p><h3>Quyền lợi</h3><ul><li>Thu nhập hấp dẫn, lương thưởng cạnh tranh theo năng lực</li><li>Thưởng các Ngày lễ, Tết (theo chính sách ngân hàng từng thời kỳ)</li><li>Được vay ưu đãi theo chính sách ngân hàng từng thời kỳ</li><li>Chế độ ngày phép hấp dẫn theo cấp bậc công việc</li><li>Bảo hiểm bắt buộc theo luật lao động + Bảo hiểm VPBank care cho CBNV tùy theo cấp bậc và thời gian công tác</li><li>Được tham gia các khóa đào tạo tùy thuộc vào Khung đào tạo cho từng vị trí</li><li>Thời gian làm việc: từ thứ 2 – thứ 6 &amp; sáng thứ 7</li><li>Môi trường làm việc năng động, thân thiện, có nhiều cơ hội học đào tạo, học hỏi và phát triển; được tham gia nhiều hoạt động văn hóa thú vị (cuộc thi về thể thao, tài năng, hoạt động teambuiding...)</li></ul><h3>Địa điểm làm việc</h3><p>- Hà Nội: VPBank Tower, 89 Láng Hạ, Đống Đa</p><p><br></p>', 15000000, 30000000, 2, 4, 'offline', 'fulltime', '2024-06-08 00:00:00', 2, 6, 'Nhân viên', 'female', 1, '2024-05-22 06:04:59', '2024-05-22 06:04:59'),
(9, 2, 'Chuyên Viên Cao Cấp Phát Triển Nền Tảng Ứng Dụng Web ( Web Developer ) - Hà Nội', '<p><strong>Mục đích chức danh:</strong></p><p>- Đóng vai trò quan trọng trong việc duy trì và phát triển các ứng dụng nghiệp vụ, hệ thống báo cáo BI, Dashboard, dữ liệu báo cáo trên nền tảng web cho Khối Tài chính.</p><p>- Phân tích, nghiên cứu, đánh giá, thiết kế, tư vấn và chi tiết hóa giải pháp công nghệ với các khối nghiệp vụ, kinh doanh về dịch vụ của Khối Tài chính trên nền tảng web.</p><p><strong>Mô tả công việc:</strong></p><p>​1.&nbsp;<strong>Vận hành ứng dụng web</strong></p><ul><li>Vận hành đảm bảo hoạt động ổn định hệ thống ứng dụng của khối Tài chính trên nền tảng web bao gồm các tính năng Tin tức truyển thông; Workflow phê duyệt luân chuyển văn bản; Hệ thống báo cáo BI Dashboard, chia sẻ files; Hệ thống thư viện văn bản online; Hệ thống quản lý khóa học.</li><li>Hỗ trợ người sử dụng các vấn đề tác nghiệp trên hệ thống ứng dụng, và các lỗi phát sinh.</li><li><em>Cấp phát user, phân quyền người dùng.</em></li></ul><p><strong>2. Phát triển ứng dụng web</strong></p><ul><li>Tiếp nhận yêu cầu điều chỉnh/phát triển ứng dụng từ trưởng nhóm/trưởng phòng và từ đó phân tích yêu cầu, xây dựng kế hoạch triển khai.</li><li>Thực hiện phát triển ứng dụng bao gồm các công việc thiết kế giao diện, viết mã lệnh, luồng xử lý bằng ngôn ngữ .net</li><li>Phối hợp cùng bộ phận hệ thống tài chính kiểm thử ứng dụng.</li><li>Triển khai ứng dụng lên Server khối Tài chính.</li><li>Xây dựng các tài liệu phát triển, vận hành, mô tả hệ thống, hướng dẫn sử dụng cho người dùng</li><li>Nghiên cứu, cập nhật các công nghệ, kỹ thuật mới, tiên tiến cho hệ thống nhằm nâng cao trải nghiệm ứng dụng và dịch vụ cho người sử dụng.</li></ul><p><strong>3. Quản lý con người</strong></p><ul><li>Tham gia các khóa đào tạo nội bộ để nâng cao kiến thức về nghiệp vụ ngân hàng cũng như kĩ năng mềm để thực hiện công việc hiệu quả hơn.</li><li>Tham gia đào tạo nội bộ, hướng dẫn các thành viên khác sử dụng và khai thác tối đa ứng dụng</li></ul><p><strong>4. Khác:</strong></p><p>Đưa ra các đề xuất nhằm nâng cao hiệu quả công việc. Thực hiện các công việc khác theo sự phân công của Trưởng phòng.</p><h3>Yêu cầu ứng viên</h3><p><strong>1. Trình độ Học vấn</strong>:</p><p>Tốt nghiệp Đại học trở lên chuyên ngành công nghệ thông tin, tin học kinh tế, hệ thống thông tin quản lý...</p><p><strong>2. Các Kinh nghiệm liên quan:</strong></p><p>- Kinh nghiệm: Có ít nhất 2-3 năm kinh nghiệm làm việc ở các vị trí phát triển ứng dụng trên nền tảng web.</p><p>- Ưu tiên làm việc trong phát triển giải pháp báo cáo thông minh Dashboard, BI.</p><p><strong>3. Kiến thức/ Chuyên môn có liên quan:</strong></p><ul><li>Thành thạo lập trình với ngôn ngữ .net, model MVC, WCF</li><li>Thành thạo HTML5/CSS, Javascript, Bootstrap, JQuery</li><li>Có kiến thức chuyên môn tốt về các hệ quản trị cơ sở dữ liệu CSDL (MS SQL, Oracle, DB2...).</li><li>Có kiến thức tốt về kiến trúc phần mềm, thiết kế phần mềm, triền khai phần mềm.</li><li>Hiểu biết/kinh nghiệp thực tế về Responsive Website, Single Page Application (SPA), Mobile, Web API... các xu hướng thiết kế website mới hiện nay là lợi thế.</li><li>Có tư duy sáng tạo, thẩm mỹ sử dụng thành thạo các phần mềm thiết kế như Photoshop, Illustrator... sẽ là một lợi thế.</li><li>Có kiến thức tốt về tuning performance câu lệnh SQL, luồng ETL và CSDL là một lợi thế.</li></ul><p><strong>4. Các Kỹ Năng:</strong></p><ul><li>Trình độ Tin học: thành thạo tin văn phòng, các công cụ lập trình</li><li>Trình độ ngoại ngữ (Tiếng Anh): đọc hiểu tài liệu tiếng Anh</li></ul><p><strong>5. Các năng lực khác<em>:</em></strong></p><p>- Khả năng nắm bắt công việc nhanh, quản lý, sắp xếp, xử lý công việc khoa học</p><p>- Khả năng làm việc độc lập, phối hợp làm việc nhóm tốt</p><p>- Khả năng giao tiếp, đàm phán, thuyết phục tốt</p><p>- Có khả năng hoạch định công việc, có tinh thần trách nhiệm cao trong công việc.</p><h3>Quyền lợi</h3><ul><li>Thu nhập hấp dẫn, lương thưởng cạnh tranh theo năng lực</li><li>Thưởng các Ngày lễ, Tết (theo chính sách ngân hàng từng thời kỳ)</li><li>Được vay ưu đãi theo chính sách ngân hàng từng thời kỳ</li><li>Chế độ ngày phép hấp dẫn theo cấp bậc công việc</li><li>Bảo hiểm bắt buộc theo luật lao động + Bảo hiểm VPBank care cho CBNV tùy theo cấp bậc và thời gian công tác</li><li>Được tham gia các khóa đào tạo tùy thuộc vào Khung đào tạo cho từng vị trí</li><li>Thời gian làm việc: từ thứ 2 – thứ 6 &amp; sáng thứ 7</li><li>Môi trường làm việc năng động, thân thiện, có nhiều cơ hội học đào tạo, học hỏi và phát triển; được tham gia nhiều hoạt động văn hóa thú vị (cuộc thi về thể thao, tài năng, hoạt động teambuiding...)</li></ul><h3>Địa điểm làm việc</h3><p>- Hà Nội: VPBank Tower, 89 Láng Hạ, Đống Đa</p>', 30000000, 40000000, 2, 4, 'offline', 'fulltime', '2024-06-08 00:00:00', 2, 6, 'Nhân viên', 'male', 1, '2024-05-22 06:06:30', '2024-05-22 06:06:30'),
(10, 2, 'Chuyên Viên Quan Hệ Khách Hàng Ưu Tiên - Hồ Chí Minh', '<p><strong><u>Địa điểm:</u></strong></p><ul><li>Hồ Chí Minh: Khu vực Quận 1, Quận 2, Quận 3, Quận 7, Bình Thạnh, Quận 9, Thủ Đức, Phú Nhuận, Gò Vấp</li></ul><p><strong>1. Kế hoạch và Quản lý:</strong></p><ul><li>Nhận và hoàn thành chỉ tiêu (KPIs) theo từng thời kỳ của vị trí Chuyên viên Quan hệ Khách hàng Ưu tiên</li><li>Tuân thủ các chiến lược và định hướng kinh doanh của các cấp lãnh đạo</li><li>Tham gia đầy đủ các hoạt động bán hàng, đào tạo</li><li>Quản lý và chăm sóc khách hàng thuộc nhóm khách hàng cao cấp của đơn vị</li><li>Đề xuất/Kiến nghị với lãnh đạo đơn vị về cách thức phát triển khách hàng nhóm khách hàng cao cấp của đơn vị</li><li>Đưa ra các sáng kiến/gợi ý xác đáng trong công tác chăm sóc khách hàng, phục vụ khách hàng nhằm tối đa hóa các hoạt động dịch vụ khiến khách hàng hài lòng và trên mức hài lòng</li></ul><p><strong>2. Các công việc hàng ngày:</strong></p><ul><li>Chủ động quản trị danh mục KH nắm giữ, theo dõi kết quả bán hàng và tình hình thực hiện KPI của mình đảm bảo năng suất tối đa</li><li>Tìm kiếm và xây dựng quan hệ khách hàng cao cấp nhằm bán các sản phẩm ngân hàng tới các khách hàng</li><li>Quản lý danh mục khách hàng và khách hàng tiềm năng</li><li>Bán, bán chéo và tối đa hóa việc bán hàng cho khách hàng cao cấp</li><li>Trực tiếp nhận yêu cầu từ khách hàng và thực hiện giao dịch cho khách hàng tuân thủ quy định của ngân hàng</li><li>Chăm sóc khách hàng theo qui định và yêu cầu của ngân hàng giúp khách hàng trung thành với ngân hàng</li><li>Phối hợp với cấp quản lý triền khai các kế hoạch kinh doanh, hoạt động bán.</li><li>Quản lý và phối hợp với các bộ phận liên quan tổ chức các chương trình chăm sóc KH, các sự kiện đặc biệt tri ân KH, các chiến dịch bán hàng, các hoạt động đào tạo và huấn luyện</li><li>Chăm sóc và xây dựng mạng lưới quan hệ khách hàng cao cấp nhằm phát triền và mở rộng danh mục KHUT, Tối đa hóa việc khai thác/bán chéo danh mục KHUT</li><li>Thực hiện các sáng kiến và công việc để nâng cao trải nghiệm khách hàng</li><li>Tuân thủ nghiêm túc Nội quy lao động/ Quản trị rủi ro của Ngân hàng</li></ul><h3>Yêu cầu ứng viên</h3><p><strong>1. Trình độ Học vấn</strong>: Tốt nghiệp từ Cao đẳng trở lên ở một trong các chuyên ngành: Ngân hàng, tài chính, quản trị kinh doanh, đầu tư, bảo hiểm, bất động sản, chứng khoán hoặc các chuyên ngành có liên quan khác</p><p><strong>2. Kiến thức/ Chuyên môn Có Liên Quan</strong></p><ul><li>Am hiểu các sản phẩm, dịch vụ tài chính - ngân hàng dành cho khách hàng ưu tiên, khách hàng cao cấp (cá nhân)</li><li>Cần có kinh nghiệm 2 năm trở lên trong lĩnh vực ngân hàng tài chính , đầu tư hoặc lĩnh vực dịch vụ cao cấp (như khách sạn/ du lịch)</li><li>Có khả năng làm việc độc lập và phối hợp</li><li>Tốt nghiệp đại học chuyên ngành tài chính/ngân hàng/kinh tế/ marketing, khách sạn.</li><li>Quan hệ rộng, có khả năng chăm sóc KH cao cấp.</li></ul><p><strong>3. Các Kỹ Năng</strong></p><ul><li>Kỹ năng chăm sóc KH đặc thù, xây dựng quan hệ và phát triển mạng lưới KH cao cấp tốt.</li><li>Kỹ năng đàm phán thương lương, bán hàng và giải quyết vấn đề tốt.</li><li>Có kỹ năng quan hệ và giao tiếp tốt</li></ul><p><strong>4.</strong>&nbsp;<strong>Các Kinh nghiệm Liên quan:&nbsp;</strong>Có kinh nghiệm trong việc bán hàng, chăm sóc KH cao cấp.</p><p><strong>5.</strong>&nbsp;<strong>Các năng lực cần có:</strong></p><ul><li>Am hiểu sâu rộng các sản phẩm dịch vụ dành cho KH cao cấp</li><li>Có kinh nghiệm hiểu biết tốt về sản phẩm đầu tư và bảo hiểm</li><li>Khả năng chịu được áp lực công việc.</li><li>Có tác phong chuyên nghiệp.luôn tuân thủ trung thực và minh bạch, đảm bảo sự tin tưởng từ phía lãnh đạo và khách hàng</li></ul><h3>Quyền lợi</h3><ul><li>Thu nhập hấp dẫn, lương thưởng cạnh tranh theo năng lực</li><li>Thưởng các Ngày lễ, Tết (theo chính sách ngân hàng từng thời kỳ)</li><li>Được vay ưu đãi theo chính sách ngân hàng từng thời kỳ</li><li>Chế độ ngày phép hấp dẫn theo cấp bậc công việc, được hưởng chế độ du lịch hè</li><li>Bảo hiểm bắt buộc theo luật lao động + Bảo hiểm VPBank care cho CBNV tùy theo cấp bậc và thời gian công tác</li><li>Được tham gia các khóa đào tạo tùy thuộc vào Khung đào tạo cho từng vị trí</li><li>Thời gian làm việc: từ thứ 2 – thứ 6 &amp; sáng thứ 7</li><li>Môi trường làm việc năng động, thân thiện, có nhiều cơ hội học đào tạo, học hỏi và phát triển; được tham gia nhiều hoạt động văn hóa thú vị (cuộc thi về thể thao, tài năng, hoạt động teambuiding...)</li></ul><h3>Địa điểm làm việc</h3><p>- Hồ Chí Minh</p>', 10000000, 20000000, 2, 1, 'offline', 'fulltime', '2024-06-08 00:00:00', 2, 6, 'Nhân viên', 'male', 79, '2024-05-22 06:09:16', '2024-05-22 06:09:16'),
(11, 2, 'Chuyên Viên Chính Quản Lý Sản Phẩm Huy Động - TA050 ', '<h3>Mô tả công việc</h3><ul><li>Nghiên cứu thị trường, đối thủ cạnh tranh và tìm hiểu nhu cầu khách hàng để hỗ trợ xây dựng quy định, quy trình, biểu mẫu, chính sách giá cho các sản phẩm mới; cải tiến, điều chỉnh các sản phẩm hiện hữu cho các sản phẩm thuộc phòng huy động vốn quản lý.</li><li>Chịu trách nhiệm theo dõi, quản lý báo cáo của các sản phẩm được giao;</li><li>Thực hiện các hoạt động hỗ trợ bán hàng, giải đáp các thắc mắc của đơn vị kinh doanh/dịch vụ về khách hàng về các sản phẩm/dịch vụ của Phòng huy động vốn quản lý.</li><li>Thực hiện các nhiệm vụ khác theo chỉ đạo của Trưởng bộ phận Phát triển sản phẩm, Trưởng phòng huy động vốn, Giám đốc trung tâm SP Huy động vốn &amp; Phí, Ban Giám đốc Khối khách hàng cá nhân và các cấp quản lý có thẩm quyền khác trong từng thời kỳ</li></ul><h3>Yêu cầu ứng viên</h3><p><strong>1. Trình độ học vấn:</strong></p><ul><li>Tốt nghiệp bằng cử nhân</li></ul><p><strong>2. Kiến thức/ chuyên môn có liên quan:</strong></p><ul><li>Hiểu biết các sản phẩm huy động vốn</li><li>Hiểu biết về tình hình thị trường, sản phẩm, dịch vụ ngân hàng, đặc biệt là ngân hàng bán lẻ.</li></ul><p><strong>3. Các kỹ năng:</strong></p><ul><li>Kỹ năng giải quyết vấn đề</li><li>Kỹ năng giao tiếp</li><li>Kỹ năng làm việc nhóm</li><li>Kỹ năng Tiếng Anh</li></ul><p><strong>4. Các kinh nghiệm liên quan:</strong></p><ul><li>Tối thiểu 1 năm kinh nghiệm làm việc trong Ngân hàng bán lẻ, ưu tiên có kinh nghiệm về phát triến sản phẩm</li></ul><p><strong>5. Các năng lực cần có/ Required Competencies</strong></p><ul><li>Khả năng phân tích, học hỏi nhanh</li></ul><h3>Quyền lợi</h3><ul><li>Thu nhập hấp dẫn, lương thưởng cạnh tranh theo năng lực</li><li>Thưởng các Ngày lễ, Tết (theo chính sách ngân hàng từng thời kỳ)</li><li>Được vay ưu đãi theo chính sách ngân hàng từng thời kỳ</li><li>Chế độ ngày phép hấp dẫn theo cấp bậc công việc</li><li>Bảo hiểm bắt buộc theo luật lao động + Bảo hiểm VPBank care cho CBNV tùy theo cấp bậc và thời gian công tác</li><li>Được tham gia các khóa đào tạo tùy thuộc vào Khung đào tạo cho từng vị trí</li><li>Thời gian làm việc: từ thứ 2 – thứ 6 &amp; sáng thứ 7</li><li>Môi trường làm việc năng động, thân thiện, có nhiều cơ hội học đào tạo, học hỏi và phát triển; được tham gia nhiều hoạt động văn hóa thú vị (cuộc thi về thể thao, tài năng, hoạt động teambuiding...)</li></ul><h3>Địa điểm làm việc</h3><p>- Hà Nội</p><h3>Thời gian làm việc</h3><p>Thứ 2 - Thứ 6 (từ 08:00 đến 17:00)</p>', 10000000, 20000000, 2, 2, 'offline', 'fulltime', '2024-06-15 00:00:00', 2, 6, 'Nhân viên', 'female', 1, '2024-05-22 06:10:44', '2024-05-22 06:10:44'),
(12, 2, 'Chuyên Viên Hỗ Trợ Nghiệp Vụ - Bảo Hiểm Phi Nhân Thọ-TA050', '<h3>Mô tả công việc</h3><ul><li>Tra soát, ghi nhận kết quả icnentive cho cán bộ Dịch vụ KH</li><li>Phối hợp chi trả incentive chương trình salecontest của DVKH</li><li>Cập nhật kết quả chương trình thi đua của bảo hiểm tới đầu mối hỗ trợ</li><li>Thiết kế bản tin truyền thông các chương trình thi đua/hoạt động về bảo hiểm</li><li>Điều phối quà tặng các chương trình minishow/seminar của BH</li><li>Hỗ trợ 1 số nghiệp vụ về hệ thống báo hiểm : phát triển/điều chỉnh hệ thống BH, UAT hệ thống BH</li><li>Giải đáp thắc mắc, cung cấp mẫu biểu, tài liệu sản phẩm bảo hiểm cho ĐKVD</li><li>Phối hợp đăng ký lịch đào tạo sản phẩm bảo hiểm cho ĐVKD</li><li>Hỗ trợ các request khác theo yêu cầu của Lãnh đạo.</li></ul><h3>Yêu cầu ứng viên</h3><p><strong>1. Trình độ Học vấn</strong></p><p><strong>Educational Qualifications</strong></p><p>Trình độ đại học</p><p><strong>2. Các Kinh nghiệm liên quan/ Relevant Experience</strong></p><ul><li>Kinh nghiệm về bảo hiểm, ngân hàng ( 1 năm trở lên)</li><li>Kinh nghiệm về data số liệu, truyền thông (1 năm trở lên)</li></ul><p><strong>3. Kiến thức/ Chuyên môn có liên Quan</strong></p><p><strong>Relevant Knowledge/ Expertise</strong></p><p>Kiến thức về bảo hiểm và những kiến thức liên quan đến công việc, kiến thức xã hội...</p><p><strong>4. Các Kỹ Năng/ Skills</strong></p><p>Word, Excel, PowerPoint, viso</p><p><strong>5. Các năng lực khác/ others</strong></p><p>Khả năng tư duy, logic, làm việc nhóm, cẩn thận, có kỹ năng giao tiếp tốt, chịu được áp lực công việc</p><h3>Quyền lợi</h3><ul><li><strong>Mức thu nhập hấp dẫn và cạnh tranh trong ngành Ngân hàng và Dịch vụ tài chính</strong>:</li><li>Lương thỏa thuận phù hợp theo năng lực;</li><li>Lương tháng 13 + Thưởng thành tích cuối năm;</li><li>Phụ cấp (ăn trưa, xăng xe, điện thoại, độc hại, thâm niên, ...);</li><li>Incentive theo hiệu quả làm việc;</li><li>Thưởng thúc đẩy theo Tháng/Quý/Năm, ...</li><li><strong>Đảm bảo các quyền lợi theo quy định của Pháp luật và Ngân hàng VPBank</strong>:</li><li>BHXH, BHYT, BHTN theo quy định;</li><li>Khám sức khỏe định kỳ hàng năm;</li><li>Bảo hiểm sức khỏe VPBank Care (BH tai nạn 24/7, BH sức khỏe AON, BH người thân);</li><li>14 ngày nghỉ phép năm có hưởng lương, nghỉ chế độ có hưởng lương;</li><li>Nghỉ vào các dịp Lễ/Tết theo quy định, nhận quà từ VPBank &amp; Công ty;</li><li>Du lịch thường niên;</li><li>Tài khoản VPBank Staff, miễn phí dịch vụ ngân hàng;</li><li>Vay gắn kết với lãi suất ưu đãi cho CBNV có hiệu quả làm việc xuất sắc; ...</li><li><strong>Môi trường làm việc năng động, cơ hội thăng tiến</strong>: đánh giá hiệu quả làm việc 2 lần/năm, điều chỉnh lương định kỳ 1 lần/năm, điều chỉnh lương ngoại lệ cho CBNV hoàn thành xuất sắc công việc;</li><li><strong>Các khoá đào tạo kỹ năng, chuyên môn nghiệp vụ, kiến thức chuyên ngành:</strong>&nbsp;đào tạo tân tuyển, đào tạo chuyên đề nội bộ, Công ty hỗ trợ chi phí cho các khoá ngắn hạn bên ngoài;</li><li><strong>Tham gia các hoạt động Văn Thể Mỹ của Công ty và Ngân hàng</strong>: Hội thao VPBank (bóng đá, cầu lông, cờ vua, ...); Cuộc thi Sing &amp; Dance, Thi Trạng Nguyên; các chuyến đi tình nguyện, ....</li></ul><h3>Địa điểm làm việc</h3><p>- Hà Nội: 89 Láng Hạ, Đống Đa</p><h3>Thời gian làm việc</h3><p>Thứ 2 - Thứ 6 (từ 08:00 đến 17:00)</p>', 10000000, 15000000, 3, 0, 'offline', 'fulltime', '2024-06-15 00:00:00', 2, 6, 'Nhân viên', 'male', 1, '2024-05-22 06:12:11', '2024-05-22 06:12:11'),
(13, 2, 'Chuyên Viên Tổng Đài Chăm Sóc Khách Hàng – OPES – TA137', '<h3>Mô tả công việc</h3><ul><li>Tiếp nhận thông tin cơ bản ban đầu về tổn thất liên quan tới bồi thường Bảo hiểm xe cơ giới trong phạm vi hoạt động đại lý bảo hiểm liên kết với ngân hàng và hướng dẫn KH các thủ tục để được hỗ trợ bồi thường.</li><li>Tư vấn thông tin liên quan tới Bảo hiểm Bắt buộc tự nguyện dân sự của chủ xe cơ giới có vay vốn tại ngân hàng: các thắc mắc, các vấn đề cần tìm hiểu về sản phẩm bảo hiểm bắt buộc tự nguyện dân sự;</li><li>Thực hiện các cuộc gọi ra xác nhận yêu cầu bồi thường và hỗ trợ khách hàng trên các hành trình bồi thường bảo hiểm xe cơ giới khi KH mua bảo hiểm qua các đại lý liên kết ngân hàng và khảo sát hài lòng Khách hàng theo từng giai đoạn của quy trình bồi thường;</li><li>Hỗ trợ cho các yêu cầu phát sinh khác qua Tổng đài về các sản phẩm, dịch vụ của Ngân hàng;</li><li>Làm việc theo ca (trong đó ca đêm khoảng 4-5 ca/tháng)</li></ul><h3>Yêu cầu ứng viên</h3><ul><li>Tốt nghiệp Cao đẳng/Đại học trở lên</li><li>Tốt nghiệp với các chuyên ngành: kinh tế, tài chính, ngân hàng, luật ...</li><li>Có kinh nghiệm về chăm sóc Khách hàng, ngân hàng hoặc bảo hiểm là lợi thế</li><li>Giọng nói chuẩn, không nói ngọng, không nói giọng đia phương</li><li>Kỹ năng giao tiếp tốt;</li></ul><h3>Quyền lợi</h3><ul><li>Thu nhập hấp dẫn, lương thưởng cạnh tranh theo năng lực</li><li>Thưởng các Ngày lễ, Tết (theo chính sách ngân hàng từng thời kỳ)</li><li>Được vay ưu đãi theo chính sách ngân hàng từng thời kỳ</li><li>Chế độ ngày phép hấp dẫn theo cấp bậc công việc</li><li>Bảo hiểm bắt buộc theo luật lao động + Bảo hiểm VPBank care cho CBNV tùy theo cấp bậc và thời gian công tác</li><li>Được tham gia các khóa đào tạo tùy thuộc vào Khung đào tạo cho từng vị trí</li><li>Thời gian làm việc: từ thứ 2 – thứ 6 &amp; sáng thứ 7</li><li>Môi trường làm việc năng động, thân thiện, có nhiều cơ hội học đào tạo, học hỏi và phát triển; được tham gia nhiều hoạt động văn hóa thú vị (cuộc thi về thể thao, tài năng, hoạt động teambuiding...)</li></ul><h3>Địa điểm làm việc</h3><p>- Hà Nội</p>', 10000000, 13000000, 1, 0, 'offline', 'fulltime', '2024-06-07 00:00:00', 2, 6, 'Nhân viên', 'female', 1, '2024-05-22 06:13:27', '2024-05-22 06:13:27'),
(14, 2, 'Chuyên Gia Thúc Đẩy Bán Sản Phẩm Casa Và Payroll - TA050', '<h3>Mô tả công việc</h3><ul><li>Xây dựng kế hoạch ngân sách &amp; kế hoạch hành động triển khai và thúc đẩy sản phẩm Tài khoản thanh toán, thẻ ghi nợ &amp; Dịch vụ thu phí của KHCN</li><li>Quản lý việc nghiên cứu, xây dựng &amp; phát triển sản phẩm tiền gửi không kỳ hạn, thẻ ghi nợ và các dịch vụ thu phí thông qua việc quản lý công tác nghiên cứu thị trường, đối thủ cạnh tranh và tìm hiểu nhu cầu khách hàng; xây dựng quy định, quy trình, biểu mẫu, chính sách giá cho các sản phẩm mới; cải tiến, điều chỉnh các sản phẩm hiện hữu.</li><li>Chịu trách nhiệm theo dõi, quản lý doanh thu và lợi nhuận các sản phẩm tài khoản thanh toán, thẻ ghi nợ và dịch vụ thu phí; Quản trị và cung cấp các báo cáo liên quan cho các Phòng ban liên quan, các cơ quan quản lý và đơn vị kinh doanh; cân bằng giữa rủi ro và lợi nhuận của sản phẩm.</li><li>Quản lý công tác triển khai, thúc đẩy và hỗ trợ bán hàng các sản phẩm quản lý thông qua các hoạt động: quản lý việc truyền thông đào tạo về sản phẩm; xây dựng, phát động và triển khai các chương trình thúc đẩy bán hàng &amp; chương trình marketing SP đến khách hàng; quản lý hiệu quả công tác hỗ trợ các đơn vị kinh doanh; quản lý việc tuân thủ quy trình bán sản phẩm tại các đơn vị kinh doanh</li><li>Dẫn dắt nhóm 3-4 thành viên để thực hiện các hoạt động thúc đẩy danh mục và sản phẩm Casa &amp; Payment.</li><li>Thực hiện các nhiệm vụ khác theo chỉ đạo của Trưởng phòng SP tài khoản thanh toán &amp; trả lương; Giám đốc Trung tâm Quản lý kinh doanh khách hàng trung lưu và sản phẩm huy động vốn; Ban Giám đốc Khối khách hàng cá nhân và các cấp quản lý có thẩm quyền khác trong từng thời kỳ.</li></ul><h3>Yêu cầu ứng viên</h3><p><strong>1. Trình độ Học vấn</strong></p><p>Educational Qualifications</p><ul><li>Tốt nghiệp bằng cử nhân: Tài chính Ngân hàng/ Quản trị kinh doanh/ Marketing</li></ul><p><strong>2. Các Kinh nghiệm liên quan/ Relevant Experienc</strong>e</p><ul><li>Hiểu biết về lĩnh vực phát triển và quản lý sản phẩm tài khoản thanh toán và thẻ ghi nợ</li><li>Hiểu biết về tình hình thị trường, sản phẩm, dịch vụ công nghệ số của Ngân hàng tại Việt Nam</li><li>Hiểu biết về hoạt động Marketing sản phẩm/ Go-to-market sản phẩm</li></ul><p><strong>3. Kiến thức/ Chuyên môn có liên Quan</strong></p><p>Relevant Knowledge/ Expertise</p><ul><li>Tối thiểu 3 năm kinh nghiệm làm việc trong Ngân hàng bán lẻ hoặc tương đương</li><li>Tối thiểu 2 năm kinh nghiệm quản lý trong lĩnh vực trong lĩnh vực phát triển sản phẩm hoặc marketing.</li></ul><p><strong>4. Các Kỹ Năng/ Skills</strong></p><ul><li>Kỹ năng quản lý</li><li>Kỹ năng ra quyết định</li><li>Kỹ năng thuyết trình</li><li>Kỹ năng giao tiếp</li><li>Kỹ năng tiếng Anh</li><li>Có khả năng sử dụng tốt Powerpoint, hoặc các phần mềm thiết kế hình ảnh là một ưu tiên</li></ul><p><strong>5. Các năng lực khác/ others</strong></p><ul><li>Khả năng xây kế hoạch</li><li>Chịu áp lực cao</li><li>Sáng tạo và nắm bắt các xu hướng thị trường liên quan đế sản phẩm Ngân hàng</li></ul><h3>Quyền lợi</h3><ul><li><strong>Mức thu nhập hấp dẫn và cạnh tranh trong ngành Ngân hàng và Dịch vụ tài chính</strong>:</li><li>Lương thỏa thuận phù hợp theo năng lực;</li><li>Lương tháng 13 + Thưởng thành tích cuối năm;</li><li>Phụ cấp (ăn trưa, xăng xe, điện thoại, độc hại, thâm niên, ...);</li><li>Incentive theo hiệu quả làm việc;</li><li>Thưởng thúc đẩy theo Tháng/Quý/Năm, ...</li><li><strong>Đảm bảo các quyền lợi theo quy định của Pháp luật và Ngân hàng VPBank</strong>:</li><li>BHXH, BHYT, BHTN theo quy định;</li><li>Khám sức khỏe định kỳ hàng năm;</li><li>Bảo hiểm sức khỏe VPBank Care (BH tai nạn 24/7, BH sức khỏe AON, BH người thân);</li><li>14 ngày nghỉ phép năm có hưởng lương, nghỉ chế độ có hưởng lương;</li><li>Nghỉ vào các dịp Lễ/Tết theo quy định, nhận quà từ VPBank &amp; Công ty;</li><li>Du lịch thường niên;</li><li>Tài khoản VPBank Staff, miễn phí dịch vụ ngân hàng;</li><li>Vay gắn kết với lãi suất ưu đãi cho CBNV có hiệu quả làm việc xuất sắc; ...</li><li><strong>Môi trường làm việc năng động, cơ hội thăng tiến</strong>: đánh giá hiệu quả làm việc 2 lần/năm, điều chỉnh lương định kỳ 1 lần/năm, điều chỉnh lương ngoại lệ cho CBNV hoàn thành xuất sắc công việc;</li><li><strong>Các khoá đào tạo kỹ năng, chuyên môn nghiệp vụ, kiến thức chuyên ngành:</strong>&nbsp;đào tạo tân tuyển, đào tạo chuyên đề nội bộ, Công ty hỗ trợ chi phí cho các khoá ngắn hạn bên ngoài;</li><li><strong>Tham gia các hoạt động Văn Thể Mỹ của Công ty và Ngân hàng</strong>: Hội thao VPBank (bóng đá, cầu lông, cờ vua, ...); Cuộc thi Sing &amp; Dance, Thi Trạng Nguyên; các chuyến đi tình nguyện, ....</li></ul><h3>Địa điểm làm việc</h3><p>- Hà Nội</p>', 25000000, 40000000, 2, 5, 'offline', 'fulltime', '2024-06-16 00:00:00', 2, 6, 'Nhân viên', 'male', 1, '2024-05-22 06:14:44', '2024-05-22 06:14:44');
INSERT INTO `jobs` (`id`, `company_id`, `title`, `description`, `min_salary`, `max_salary`, `recruitment_number`, `working_experience`, `working_method`, `working_type`, `expired_date`, `start_week_day`, `end_week_day`, `degree`, `gender`, `province_id`, `createdAt`, `updatedAt`) VALUES
(15, 2, 'Senior Java Developer - TA131', '<h3>Mô tả công việc</h3><ul><li>End-to-end responsible for development and operation of the Loan Origination Product, including but not limited to Loan Origination System for Retail Customer, Loan Origination System for Corporate Customer, Internal Credit Bureau System and other directly related systems in this domain.</li><li>Research about service related to this domain.</li><li>Proactively offer solutions, investigate, collect and analyze business requests about this domain. Design SRS for development. Design processes, reports, charts and formulas for business understanding about business and operation rules related to this domain.</li><li>Design, develop, and deploy soulutions to actualize requirement analysis results in order to build up applications that can meet business requirements of this domain.</li><li>Develop detailed documents, including analysis document, developing document, testcase, SOM documents of change requests for this domain.</li><li>Study and upgrade application versions following recommendation from application providers related to this domain.</li><li>Manage testing data, tool and environment related to this domain.</li><li>Manage vendors, services quality of vendors/other service providers related to this domain and take full responsibility on their services.</li><li>Level 2 and Level 3 support for the corresponding systems in this domain, which provides expertise to fulfill all customer requests, according to the IT Service SLA.</li><li>Being responsible to resolve and/or managing other domain lead to resolve incidents and problems related to customer in this domain in a timely manner, which minimize the business lost.</li><li>Collect and report statistics regarding status and performance of relevant OLAs.</li><li>Maintain stability, availability and quality of services related to this domain. Perform regular maintenance as per recommendations for relevant system applications.</li><li>Proactively propose IT service process improvements, changes in system, business process changes related to this domain</li></ul><h3>Yêu cầu ứng viên</h3><p><strong>1. Educational Qualifications</strong></p><ul><li>Bachelor’s degree in Computer Science, Engineering, Mathematics or related field of study</li></ul><p><strong>2. Relevant Knowledge/ Expertise</strong></p><p>5-10 years experiences in software development and at least 3 years in banking and fintech domain.</p><p>An understanding of bank business processes, fintech solution and constraints.</p><p><strong>3. Relevant Experience</strong></p><ul><li>Expert in JAVA language, Spring boot, Hibernate, jpa, and solid work with IDE</li><li>Net Framework should be considered added skill.</li><li>Advanced Knowledge MS SQL, Oracle DBs</li><li>Having knowledge about microservice, Kubernetes, ability to config EKS.</li><li>Experience with source code management like Git, Gitlab, Jira.</li><li>Good understanding on webservice SOAP/Restful, Standard message JSON, XML, OOP, Design pattern ...</li><li>Knowledge on Angular, JS is big plus.</li></ul><p><strong>4. Skill</strong></p><ul><li>Ability in English reading and writing (mandatory), and speaking, listening (preferable).</li></ul><p><strong>5. Others</strong></p><ul><li><strong><em>Teamwork</em></strong>, careful, attention to detail, logical thinking.</li><li><strong>Problem-solving</strong>&nbsp;skills, ability to work under high pressure and can-do attitude.</li><li><strong><em>Self</em></strong>-development and motivation skill.</li></ul><h3>Quyền lợi</h3><ul><li><strong>Mức thu nhập hấp dẫn và cạnh tranh trong ngành Ngân hàng và Dịch vụ tài chính</strong>:</li><li>Lương thỏa thuận phù hợp theo năng lực;</li><li>Lương tháng 13 + Thưởng thành tích cuối năm;</li><li>Phụ cấp (ăn trưa, xăng xe, điện thoại, độc hại, thâm niên, ...);</li><li>Incentive theo hiệu quả làm việc;</li><li>Thưởng thúc đẩy theo Tháng/Quý/Năm, ...</li><li><strong>Đảm bảo các quyền lợi theo quy định của Pháp luật và Ngân hàng VPBank</strong>:</li><li>BHXH, BHYT, BHTN theo quy định;</li><li>Khám sức khỏe định kỳ hàng năm;</li><li>Bảo hiểm sức khỏe VPBank Care (BH tai nạn 24/7, BH sức khỏe AON, BH người thân);</li><li>14 ngày nghỉ phép năm có hưởng lương, nghỉ chế độ có hưởng lương;</li><li>Nghỉ vào các dịp Lễ/Tết theo quy định, nhận quà từ VPBank &amp; Công ty;</li><li>Du lịch thường niên;</li><li>Tài khoản VPBank Staff, miễn phí dịch vụ ngân hàng;</li><li>Vay gắn kết với lãi suất ưu đãi cho CBNV có hiệu quả làm việc xuất sắc; ...</li><li><strong>Môi trường làm việc năng động, cơ hội thăng tiến</strong>: đánh giá hiệu quả làm việc 2 lần/năm, điều chỉnh lương định kỳ 1 lần/năm, điều chỉnh lương ngoại lệ cho CBNV hoàn thành xuất sắc công việc;</li><li><strong>Các khoá đào tạo kỹ năng, chuyên môn nghiệp vụ, kiến thức chuyên ngành:</strong>&nbsp;đào tạo tân tuyển, đào tạo chuyên đề nội bộ, Công ty hỗ trợ chi phí cho các khoá ngắn hạn bên ngoài;</li><li><strong>Tham gia các hoạt động Văn Thể Mỹ của Công ty và Ngân hàng</strong>: Hội thao VPBank (bóng đá, cầu lông, cờ vua, ...); Cuộc thi Sing &amp; Dance, Thi Trạng Nguyên; các chuyến đi tình nguyện, ....</li></ul><h3>Địa điểm làm việc</h3><p>- HCM</p>', 30000000, 40000000, 2, 5, 'hybrid', 'fulltime', '2024-06-15 00:00:00', 2, 6, 'Nhân viên', 'male', 79, '2024-05-22 06:16:45', '2024-05-22 06:16:45'),
(16, 2, 'TTS Phát Triển Kinh Doanh - TTDV Ngân Hàng Số', '<h3>Mô tả công việc</h3><ul><li>Hỗ trợ phản hồi đơn vị kinh doanh về phát triển user/ TD/ Vay trên VPBank NEO;</li><li>Hỗ trợ làm bản tin truyền thông;</li><li>Hỗ trợ vận hành chi thưởng các chương trình salecontest;</li><li>Phản hồi đơn vị, CRU về các thắc mắc của Khách hàng liên quan đến chương trình khuyến mại;</li><li>Hỗ trợ triển khai bộ tài liệu đào tạo của trung tâm.</li></ul><h3>Yêu cầu ứng viên</h3><ul><li>Sinh viên năm cuối các trường Cao Đẳng/Đại học, chuyên ngành Kinh tế, Tài chính, Ngân hàng, Quản trị Kinh doanh, Marketing...</li><li>Năng động, khả năng giao tiếp tốt</li><li>Đam mê kinh doanh và yêu thích công việc trong lĩnh vực tài chính ngân hàng</li></ul><h3>Quyền lợi</h3><ul><li>Thực tập và làm việc tại Nơi làm việc Hạnh Phúc nhất Việt Nam;</li><li>Được đào tạo, hướng dẫn từ cán bộ quản lý và chuyên gia trong lĩnh vực Tài chính - Ngân hàng;</li><li>Được tiếp xúc với hệ thống vận hành chuyên nghiệp, chuẩn quốc tế;</li><li>Lộ trình trở thành nhân viên Ngân hàng sau khi kết thúc thực tập và trải qua kỳ đánh giá.</li></ul><h3>Địa điểm làm việc</h3><p>- Hà Nội</p><h3>Thời gian làm việc</h3><p>Thứ 2 - Thứ 6 (từ 08:00 đến 17:00)</p>', 2500000, 4000000, 5, 0, 'offline', 'fulltime', '2024-06-05 00:00:00', 2, 6, 'Thực tập sinh', 'male', 1, '2024-05-22 06:18:15', '2024-05-22 06:18:15'),
(17, 2, 'Segment Teamleader - AF - HO - TA050', '<h3>Mô tả công việc</h3><ul><li>Develop CVP for AF segment and sub-segments ensure market competitiveness.</li><li>Develop acquisition programs &amp;retention programs for AF client growth</li><li>Develop product’s feature &amp; product’s packages based on AF Personas</li><li>Develop client journey for AF clients to improve client’s experience via high standard process &amp; service quality</li><li>Interface with Retail Marketing/Marcom for promotion of program/product to VPB client &amp; VPBank internal.</li></ul><h3>Yêu cầu ứng viên</h3><p><strong>1. Educational Qualifications</strong></p><p>Bachelor\'s degree in banking and finance</p><p><strong>2. Relevant Experience</strong></p><p>8 Years’ Experience in banking, in the areas of Affluent segment</p><p><strong>3. Relevant Knowledge/ Expertise</strong></p><ul><li>Extensive experience in Relationship Management and Affluent and/or Private Banking business</li><li>Extensive experience in Relationship Management and Affluent and/or Private Banking business</li><li>Strong knowledge of financial products and services, with a good understanding of how economic events impact global markets.</li></ul><p><strong>4. Skills</strong></p><p>Relationship/People Management Skills, teamwork skills, Effective Communication skills</p><p><strong>5. Others</strong></p><ul><li>Active, resourceful, and highly accomplished and capable of multitasking and solving multiple priorities</li><li>Ability to work in groups and interact with departments in the bank.</li></ul><h3>Quyền lợi</h3><ul><li>Attractive income, competitive salary and bonus according to ability</li><li>Bonus on Holidays and New Year (according to banking policy from time to time)</li><li>Get preferential loans according to the bank\'s policy from time to tim</li><li>Attractive leave mode according to job rank</li><li>Compulsory insurance according to labor law &amp; VPBank care insurance for employees depending on rank and working time</li><li>Participate in training courses depending on the Training Framework for each position</li><li>Working time: Monday - Friday &amp; Saturday morning (two Saturday mornings/month off)</li><li>Dynamic, friendly working environment with many opportunities for training, learning and development; participate in many interesting cultural activities (sports event, talents, teambuilding activities...)</li></ul><h3>Địa điểm làm việc</h3><p>- Hà Nội</p>', 30000000, 40000000, 1, 5, 'offline', 'fulltime', '2024-06-15 00:00:00', 2, 6, 'Trưởng nhóm', 'male', 1, '2024-05-22 06:19:43', '2024-05-22 06:19:43'),
(18, 2, 'Senior Tester - TA050', '<h3>Mô tả công việc</h3><ul><li>Study the requirement for Micro-service application and API.</li><li>Design test scenarios for Micro-service application and API</li><li>Support SIT and UAT testing</li><li>Support verify issue/problem fix</li><li>Review and accept testing related deliverables from vendor</li></ul><h3>Yêu cầu ứng viên</h3><p><strong>1. Education/Training</strong></p><ul><li>Bachelor’s degree in Computer Science, Engineering, Mathematics, or related field of study: or equivalent education, training &amp; experience.</li></ul><p><strong>2. Knowledge/Expertise</strong></p><ul><li>Having at least 4 years’ experience with web service API testing (SOAP and Restful)</li><li>Having experience with API testing tool like SoapUI, Postman</li><li>Having experience with design and develop automation test script base on Java development language</li><li>Having experience review Test case</li><li>Having experience with database like MS SQL, MySQL, Oracle</li><li>Familiar with CI/CD tools like Jenkin, GIT, Ant, Maven, Gradle or similarly</li></ul><p><strong>3. Skills</strong></p><ul><li>Ability in English reading and writing (mandatory), and speaking, listening (preferable).</li><li>Teamwork, careful, attention to detail, logical thinking</li><li>Self-development.</li><li>Communication, negotiation, and problem solving</li></ul><p><strong>4. Relevant Experiences</strong></p><ul><li>Banking domain experiences</li><li>Agile/Scrum experiences</li></ul><h3>Quyền lợi</h3><ul><li>Competitive salary and bonus package</li><li>Staff loan with special interest rates</li><li>Traing courses based on the job, Training framework/Learning RoadMap for each position</li><li>Insurance in accordance with Labor laws + VPBank Care insurance for all employees. (insurance covered for family members for entitled employees)</li><li>Annual leave (varied based on job grade)</li><li>Travel allowance</li><li>A dynamic and friendly working environment, full of great opportunities to develop your career and abundant interesting activities to join (Sports competitions, talent contests, teambuilding...)</li><li>Working time: from Monday to Friday &amp; 2 Saturday mornings/month-Competitive salary and bonus package</li><li>Staff loan with special interest rates</li></ul><h3>Địa điểm làm việc</h3><p>- Hà Nội</p>', 20000000, 30000000, 1, 5, 'offline', 'fulltime', '2024-06-11 00:00:00', 2, 6, 'Nhân viên', 'male', 1, '2024-05-22 06:21:36', '2024-05-22 06:21:36');

-- --------------------------------------------------------

--
-- Table structure for table `job_images`
--

CREATE TABLE `job_images` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_industries`
--

CREATE TABLE `job_industries` (
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `job_id` int(11) NOT NULL,
  `industry_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_industries`
--

INSERT INTO `job_industries` (`createdAt`, `updatedAt`, `job_id`, `industry_id`) VALUES
('2024-05-22 05:46:38', '2024-05-22 05:46:38', 1, 1),
('2024-05-22 05:46:38', '2024-05-22 05:46:38', 1, 2),
('2024-05-22 05:48:55', '2024-05-22 05:48:55', 2, 3),
('2024-05-22 05:48:55', '2024-05-22 05:48:55', 2, 4),
('2024-05-22 05:50:44', '2024-05-22 05:50:44', 3, 1),
('2024-05-22 05:50:44', '2024-05-22 05:50:44', 3, 5),
('2024-05-22 05:54:02', '2024-05-22 05:54:02', 5, 1),
('2024-05-22 05:54:02', '2024-05-22 05:54:02', 5, 3),
('2024-05-22 05:54:02', '2024-05-22 05:54:02', 5, 4),
('2024-05-22 06:02:03', '2024-05-22 06:02:03', 6, 6),
('2024-05-22 06:02:03', '2024-05-22 06:02:03', 6, 7),
('2024-05-22 06:02:03', '2024-05-22 06:02:03', 6, 8),
('2024-05-22 06:03:09', '2024-05-22 06:03:09', 7, 7),
('2024-05-22 06:03:09', '2024-05-22 06:03:09', 7, 9),
('2024-05-22 06:04:59', '2024-05-22 06:04:59', 8, 1),
('2024-05-22 06:04:59', '2024-05-22 06:04:59', 8, 3),
('2024-05-22 06:04:59', '2024-05-22 06:04:59', 8, 4),
('2024-05-22 06:04:59', '2024-05-22 06:04:59', 8, 7),
('2024-05-22 06:06:30', '2024-05-22 06:06:30', 9, 1),
('2024-05-22 06:06:30', '2024-05-22 06:06:30', 9, 3),
('2024-05-22 06:06:30', '2024-05-22 06:06:30', 9, 4),
('2024-05-22 06:06:30', '2024-05-22 06:06:30', 9, 7),
('2024-05-22 06:09:16', '2024-05-22 06:09:16', 10, 5),
('2024-05-22 06:09:16', '2024-05-22 06:09:16', 10, 7),
('2024-05-22 06:09:16', '2024-05-22 06:09:16', 10, 9),
('2024-05-22 06:10:44', '2024-05-22 06:10:44', 11, 7),
('2024-05-22 06:12:11', '2024-05-22 06:12:11', 12, 7),
('2024-05-22 06:12:11', '2024-05-22 06:12:11', 12, 10),
('2024-05-22 06:13:27', '2024-05-22 06:13:27', 13, 7),
('2024-05-22 06:13:27', '2024-05-22 06:13:27', 13, 11),
('2024-05-22 06:13:27', '2024-05-22 06:13:27', 13, 12),
('2024-05-22 06:14:44', '2024-05-22 06:14:44', 14, 7),
('2024-05-22 06:14:44', '2024-05-22 06:14:44', 14, 11),
('2024-05-22 06:14:44', '2024-05-22 06:14:44', 14, 13),
('2024-05-22 06:16:45', '2024-05-22 06:16:45', 15, 3),
('2024-05-22 06:16:45', '2024-05-22 06:16:45', 15, 4),
('2024-05-22 06:16:45', '2024-05-22 06:16:45', 15, 7),
('2024-05-22 06:16:45', '2024-05-22 06:16:45', 15, 14),
('2024-05-22 06:18:15', '2024-05-22 06:18:15', 16, 5),
('2024-05-22 06:18:15', '2024-05-22 06:18:15', 16, 7),
('2024-05-22 06:19:43', '2024-05-22 06:19:43', 17, 7),
('2024-05-22 06:21:36', '2024-05-22 06:21:36', 18, 1),
('2024-05-22 06:21:36', '2024-05-22 06:21:36', 18, 3),
('2024-05-22 06:21:36', '2024-05-22 06:21:36', 18, 4),
('2024-05-22 06:21:36', '2024-05-22 06:21:36', 18, 14);

-- --------------------------------------------------------

--
-- Table structure for table `job_tags`
--

CREATE TABLE `job_tags` (
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `job_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_tags`
--

INSERT INTO `job_tags` (`createdAt`, `updatedAt`, `job_id`, `tag_id`) VALUES
('2024-05-22 05:46:38', '2024-05-22 05:46:38', 1, 1),
('2024-05-22 06:16:45', '2024-05-22 06:16:45', 15, 1),
('2024-05-22 06:16:45', '2024-05-22 06:16:45', 15, 2),
('2024-05-22 06:16:45', '2024-05-22 06:16:45', 15, 3),
('2024-05-22 06:21:36', '2024-05-22 06:21:36', 18, 1),
('2024-05-22 06:21:36', '2024-05-22 06:21:36', 18, 4),
('2024-05-22 06:21:36', '2024-05-22 06:21:36', 18, 5);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `type` enum('job_apply','job_reject','job_accept','company_react','chat') NOT NULL,
  `message` varchar(255) NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `provinces`
--

CREATE TABLE `provinces` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `provinces`
--

INSERT INTO `provinces` (`id`, `name`, `type`) VALUES
(1, 'Thành phố Hà Nội', 'Thành phố Trung ương'),
(2, 'Tỉnh Hà Giang', 'Tỉnh'),
(4, 'Tỉnh Cao Bằng', 'Tỉnh'),
(6, 'Tỉnh Bắc Kạn', 'Tỉnh'),
(8, 'Tỉnh Tuyên Quang', 'Tỉnh'),
(10, 'Tỉnh Lào Cai', 'Tỉnh'),
(11, 'Tỉnh Điện Biên', 'Tỉnh'),
(12, 'Tỉnh Lai Châu', 'Tỉnh'),
(14, 'Tỉnh Sơn La', 'Tỉnh'),
(15, 'Tỉnh Yên Bái', 'Tỉnh'),
(17, 'Tỉnh Hoà Bình', 'Tỉnh'),
(19, 'Tỉnh Thái Nguyên', 'Tỉnh'),
(20, 'Tỉnh Lạng Sơn', 'Tỉnh'),
(22, 'Tỉnh Quảng Ninh', 'Tỉnh'),
(24, 'Tỉnh Bắc Giang', 'Tỉnh'),
(25, 'Tỉnh Phú Thọ', 'Tỉnh'),
(26, 'Tỉnh Vĩnh Phúc', 'Tỉnh'),
(27, 'Tỉnh Bắc Ninh', 'Tỉnh'),
(30, 'Tỉnh Hải Dương', 'Tỉnh'),
(31, 'Thành phố Hải Phòng', 'Thành phố Trung ương'),
(33, 'Tỉnh Hưng Yên', 'Tỉnh'),
(34, 'Tỉnh Thái Bình', 'Tỉnh'),
(35, 'Tỉnh Hà Nam', 'Tỉnh'),
(36, 'Tỉnh Nam Định', 'Tỉnh'),
(37, 'Tỉnh Ninh Bình', 'Tỉnh'),
(38, 'Tỉnh Thanh Hóa', 'Tỉnh'),
(40, 'Tỉnh Nghệ An', 'Tỉnh'),
(42, 'Tỉnh Hà Tĩnh', 'Tỉnh'),
(44, 'Tỉnh Quảng Bình', 'Tỉnh'),
(45, 'Tỉnh Quảng Trị', 'Tỉnh'),
(46, 'Tỉnh Thừa Thiên Huế', 'Tỉnh'),
(48, 'Thành phố Đà Nẵng', 'Thành phố Trung ương'),
(49, 'Tỉnh Quảng Nam', 'Tỉnh'),
(51, 'Tỉnh Quảng Ngãi', 'Tỉnh'),
(52, 'Tỉnh Bình Định', 'Tỉnh'),
(54, 'Tỉnh Phú Yên', 'Tỉnh'),
(56, 'Tỉnh Khánh Hòa', 'Tỉnh'),
(58, 'Tỉnh Ninh Thuận', 'Tỉnh'),
(60, 'Tỉnh Bình Thuận', 'Tỉnh'),
(62, 'Tỉnh Kon Tum', 'Tỉnh'),
(64, 'Tỉnh Gia Lai', 'Tỉnh'),
(66, 'Tỉnh Đắk Lắk', 'Tỉnh'),
(67, 'Tỉnh Đắk Nông', 'Tỉnh'),
(68, 'Tỉnh Lâm Đồng', 'Tỉnh'),
(70, 'Tỉnh Bình Phước', 'Tỉnh'),
(72, 'Tỉnh Tây Ninh', 'Tỉnh'),
(74, 'Tỉnh Bình Dương', 'Tỉnh'),
(75, 'Tỉnh Đồng Nai', 'Tỉnh'),
(77, 'Tỉnh Bà Rịa - Vũng Tàu', 'Tỉnh'),
(79, 'Thành phố Hồ Chí Minh', 'Thành phố Trung ương'),
(80, 'Tỉnh Long An', 'Tỉnh'),
(82, 'Tỉnh Tiền Giang', 'Tỉnh'),
(83, 'Tỉnh Bến Tre', 'Tỉnh'),
(84, 'Tỉnh Trà Vinh', 'Tỉnh'),
(86, 'Tỉnh Vĩnh Long', 'Tỉnh'),
(87, 'Tỉnh Đồng Tháp', 'Tỉnh'),
(89, 'Tỉnh An Giang', 'Tỉnh'),
(91, 'Tỉnh Kiên Giang', 'Tỉnh'),
(92, 'Thành phố Cần Thơ', 'Thành phố Trung ương'),
(93, 'Tỉnh Hậu Giang', 'Tỉnh'),
(94, 'Tỉnh Sóc Trăng', 'Tỉnh'),
(95, 'Tỉnh Bạc Liêu', 'Tỉnh'),
(96, 'Tỉnh Cà Mau', 'Tỉnh');

-- --------------------------------------------------------

--
-- Table structure for table `reactions`
--

CREATE TABLE `reactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `salary_rating` int(11) DEFAULT NULL,
  `working_space_rating` int(11) DEFAULT NULL,
  `colleague_relationship_rating` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resumes`
--

CREATE TABLE `resumes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `resume_url` varchar(255) DEFAULT NULL,
  `is_uploaded` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `tag` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `tag`, `createdAt`, `updatedAt`) VALUES
(1, 'SQL', '2024-05-22 05:46:38', '2024-05-22 05:46:38'),
(2, 'Java', '2024-05-22 06:16:45', '2024-05-22 06:16:45'),
(3, 'Database', '2024-05-22 06:16:45', '2024-05-22 06:16:45'),
(4, 'GIT', '2024-05-22 06:21:36', '2024-05-22 06:21:36'),
(5, 'Test', '2024-05-22 06:21:36', '2024-05-22 06:21:36');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `gmail` varchar(255) NOT NULL,
  `role` enum('user','agent','admin') NOT NULL DEFAULT 'user',
  `avatar` varchar(255) DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `password`, `gmail`, `role`, `avatar`, `date_of_birth`, `company_id`) VALUES
(1, 'Lee Bao Anh', '$2b$12$LOcEAWliwdPpb146uFNN.u2ywdsc3d8NxskeK7/Nc7k7L8wlWld0S', 'anh.lb194470@sis.hust.edu.vn', 'user', NULL, NULL, NULL),
(2, 'AGENT1', '$2b$12$UXqQEwbPXlZx4LQb8ffLOu/DP8mt5Qdrz8n0gV3iBjPSsUULqH1B2', 'agent1@gmai.com', 'agent', NULL, NULL, 1),
(3, 'AGENT2', '$2b$12$XSNT0x8GRdnh0J4GaGZcJ.NlTSgdY03grHAxFc6gOqIpVWmIBudii', 'agent2@gmai.com', 'agent', NULL, NULL, 2),
(4, 'AGENT3', '$2b$12$USNovjQGrPnHMtZ2.bYpF.dvugN5JjmUApS9XlU0cAqPExfDuAqma', 'agent3@gmai.com', 'agent', NULL, NULL, 3),
(5, 'AGENT4', '$2b$12$HtLtpkOFQb2rxxtA/NWY0O0J.BzjZkV7ahiGE2zyvFJu9U.vGZaGm', 'agent4@gmai.com', 'agent', NULL, NULL, 4),
(6, 'AGENT5', '$2b$12$6YVsKJr/xqjoAZtqPPeD7u5zx6Me.eSEfqJoHOTy/DHrHFKyal11e', 'agent5@gmai.com', 'agent', NULL, NULL, 5),
(7, 'AGENT6', '$2b$12$1sJO6Tk8SWjV9AiVzwxWjO8xCljm4YFxMsCsCrmzkZwn66rmwlcxW', 'agent6@gmai.com', 'agent', NULL, NULL, 6),
(8, 'AGENT7', '$2b$12$h4KNtyVVhy3EAXjBbITN5uNEcOGiIl9YXq3ddfW2s7AJaNbHfpyAa', 'agent7@gmai.com', 'agent', NULL, NULL, 7),
(9, 'AGENT8', '$2b$12$jvvpLx5sXOmqxCQTm8ejhOY5LGrjhsIW9HzWqDkjFxUbbJ51Vj/F2', 'agent8@gmai.com', 'user', NULL, NULL, 8),
(10, 'AGENT9', '$2b$12$GbN1VaXVpihszw03Wg/2nupdaXUXfHHS8ruwiX/mFNjGm6Rlu6Z5K', 'agent9@gmai.com', 'agent', NULL, NULL, 9),
(12, 'AGENT10', '$2b$12$AZNXG1zJaWMX0F13shRkXeI85e24FuVHdF4WWXyDlCnCscSwhYae6', 'agent10@gmai.com', 'agent', NULL, NULL, 10);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applies`
--
ALTER TABLE `applies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `apply_unique` (`job_id`,`user_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `resume_id` (`resume_id`);

--
-- Indexes for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `bookmark_unique` (`job_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `contact_mail` (`contact_mail`),
  ADD KEY `province_id` (`province_id`);

--
-- Indexes for table `expect_jobs`
--
ALTER TABLE `expect_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `industries`
--
ALTER TABLE `industries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `industry` (`industry`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`),
  ADD KEY `province_id` (`province_id`);

--
-- Indexes for table `job_images`
--
ALTER TABLE `job_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `job_id` (`job_id`);

--
-- Indexes for table `job_industries`
--
ALTER TABLE `job_industries`
  ADD PRIMARY KEY (`job_id`,`industry_id`),
  ADD KEY `industry_id` (`industry_id`);

--
-- Indexes for table `job_tags`
--
ALTER TABLE `job_tags`
  ADD PRIMARY KEY (`job_id`,`tag_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `provinces`
--
ALTER TABLE `provinces`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reactions`
--
ALTER TABLE `reactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `company_id` (`company_id`);

--
-- Indexes for table `resumes`
--
ALTER TABLE `resumes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tag` (`tag`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `gmail` (`gmail`),
  ADD KEY `company_id` (`company_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applies`
--
ALTER TABLE `applies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chats`
--
ALTER TABLE `chats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `expect_jobs`
--
ALTER TABLE `expect_jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `industries`
--
ALTER TABLE `industries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `job_images`
--
ALTER TABLE `job_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `provinces`
--
ALTER TABLE `provinces`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `reactions`
--
ALTER TABLE `reactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resumes`
--
ALTER TABLE `resumes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applies`
--
ALTER TABLE `applies`
  ADD CONSTRAINT `applies_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `applies_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `applies_ibfk_3` FOREIGN KEY (`resume_id`) REFERENCES `resumes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD CONSTRAINT `bookmarks_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `bookmarks_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `chats`
--
ALTER TABLE `chats`
  ADD CONSTRAINT `chats_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `chats_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `companies`
--
ALTER TABLE `companies`
  ADD CONSTRAINT `companies_ibfk_1` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `expect_jobs`
--
ALTER TABLE `expect_jobs`
  ADD CONSTRAINT `expect_jobs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jobs`
--
ALTER TABLE `jobs`
  ADD CONSTRAINT `jobs_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `jobs_ibfk_2` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `job_images`
--
ALTER TABLE `job_images`
  ADD CONSTRAINT `job_images_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `job_industries`
--
ALTER TABLE `job_industries`
  ADD CONSTRAINT `job_industries_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `job_industries_ibfk_2` FOREIGN KEY (`industry_id`) REFERENCES `industries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `job_tags`
--
ALTER TABLE `job_tags`
  ADD CONSTRAINT `job_tags_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `job_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `reactions`
--
ALTER TABLE `reactions`
  ADD CONSTRAINT `reactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reactions_ibfk_2` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `resumes`
--
ALTER TABLE `resumes`
  ADD CONSTRAINT `resumes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

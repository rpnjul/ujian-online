<?php 
// Extend the TCPDF class to create custom Header and Footer
class MYPDF extends TCPDF {
    
    public function Header() {
        $image_file = K_PATH_IMAGES.'header.jpg';
        $this->Image($image_file, 15, 5, 180, '', 'JPG', '', 'T', false, 300, '', false, false, 0, false, false, false);
        $this->SetFont('helvetica', 'B', 18);
        $this->SetY(13);
       
    }

    public function Footer() {
        $this->SetY(-15);
        $this->SetFont('helvetica', 'I', 8);
        $this->Cell(0, 10, 'Universitas WWW.SATRIA.GA ', 0, false, 'C', 0, '', 0, false, 'T', 'M');
    }
}

// create new PDF document
$pdf = new MYPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);

// set document information
$pdf->SetCreator(PDF_CREATOR);
$pdf->SetAuthor('Satria Aprilian');
$pdf->SetTitle('Bukti_Ujian_'.$mhs->nim);

// set default header data
$pdf->SetHeaderData(PDF_HEADER_LOGO, PDF_HEADER_LOGO_WIDTH, PDF_HEADER_TITLE, PDF_HEADER_STRING);

// set header and footer fonts
$pdf->setHeaderFont(Array(PDF_FONT_NAME_MAIN, '', PDF_FONT_SIZE_MAIN));
$pdf->setFooterFont(Array(PDF_FONT_NAME_DATA, '', PDF_FONT_SIZE_DATA));

// set default monospaced font
$pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);

// set margins
$pdf->SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_TOP, PDF_MARGIN_RIGHT);
$pdf->SetHeaderMargin(PDF_MARGIN_HEADER);
$pdf->SetFooterMargin(PDF_MARGIN_FOOTER);

// set auto page breaks
$pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);

// set image scale factor
$pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);

// set some language-dependent strings (optional)
if (@file_exists(dirname(__FILE__).'/lang/eng.php')) {
    require_once(dirname(__FILE__).'/lang/eng.php');
    $pdf->setLanguageArray($l);
}

// ---------------------------------------------------------

// set font
$pdf->SetFont('helvetica', '', 10);

// add a page
$pdf->AddPage();

// create some HTML content
$html = <<<EOD

<br><br><br><br><br><br><br><br>
<h3 align="center">Terima Kasih Anda Telah Mengikuti Ujian Online</h3>
<br><br><br><br><br><br><br><br>
<table {style="margin-left:auto;margin-right:auto"} id="data-peserta">
    <tr bgcolor="#AEBDD2">
        <th>NIM</th>
        <td align="justify">: {$mhs->nim}</td>
    </tr>
    <tr>
        <th>Nama</th>
        <td align="justify">: {$mhs->nama}</td>
    </tr>
    <tr bgcolor="#AEBDD2">
        <th>Tanggal Ujian</th>
        <td align="justify">: {$thn}-{$bln}-{$tgl} - {$thn2}-{$bln2}-{$tgl2}</td>
    </tr>
    <tr>
        <th>Jam Ujian</th>
        <td align="justify">: {$jam}:{$menit} - {$jam2}:{$menit2}</td>
    </tr>
    <tr bgcolor="#AEBDD2">
        <th>Mata Kuliah</th>
        <td align="justify">: {$ujian->nama_matkul}</td>
    </tr>
    <tr>
        <th>Jenis Ujian</th>
        <td align="justify">: {$ujian->nama_ujian}</td>
    </tr>
    <tr bgcolor="#AEBDD2">
        <th>Jumlah Soal</th>
        <td align="justify">: {$ujian->jumlah_soal}</td>
    </tr>
    <tr>
        <th>Jawaban Benar</th>
        <td align="justify">: {$hasil->jml_benar}</td>
    </tr>
    <tr bgcolor="#AEBDD2">
        <th>Jawaban Salah</th>
        <td align="justify">: {$salah}</td>
    </tr>
</table><br><br>
<i>
<h5 align="center"> Simpan sebagai bukti bahwa anda telah mengikuti ujian online </h5><br>
<h5 align="center"> Tanggal Cetak {$datenow} </h5>
</i>
EOD;

$html .= <<<EOD
<div align="center">
<img src="{$urlweb}/assets/qrcode/{$hasil->security_key}.png" height="150" width="150"></img>
<h5 align="center" ><i>Security Key: {$hasil->security_key} </i></h5>
EOD;
// output the HTML content
$pdf->writeHTML($html, true, false, true, false);

// $pdf->SetPrintHeader(false);
// $pdf->SetPrintFooter(false);
// $pdf->AddPage();

// // create some HTML content
// $no = 1;
// $html2 = <<<EOD
//     <tbody>
//     <table>
//     <tr>
//         <td align="center">Testing {$no}</td>

//     </tr>
//     <tr>
//         <td align="center" >Testing </td>

//     </tr>
    
// EOD;
// $no++;
// $html2 .= <<<EOD
// </table>
// </tbody>
// EOD;
// // output the HTML content
// $pdf->writeHTML($html2, true, 0, true, 0);

// reset pointer to the last page
$pdf->lastPage();
// ---------------------------------------------------------

//Close and output PDF document
$pdf->Output('Bukti_Ujian'.'_'.$mhs->nim.'.pdf', 'I');

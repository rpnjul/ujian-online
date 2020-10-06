<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class HasilUjian extends CI_Controller {

	public function __construct(){
		parent::__construct();
		if (!$this->ion_auth->logged_in()){
			redirect('auth');
		}
		
		$this->load->library(['datatables']);// Load Library Ignited-Datatables
		$this->load->model('Master_model', 'master');
		$this->load->model('Ujian_model', 'ujian');
		$this->load->model('Soal_model', 'soal');
		
		$this->user = $this->ion_auth->user()->row();
	}

	public function output_json($data, $encode = true)
	{
		if($encode) $data = json_encode($data);
		$this->output->set_content_type('application/json')->set_output($data);
	}

	public function data()
	{
		$nip_dosen = null;
		
		if( $this->ion_auth->in_group('dosen') ) {
			$nip_dosen = $this->user->username;
		}

		$this->output_json($this->ujian->getHasilUjian($nip_dosen), false);
	}

	public function NilaiMhs($id)
	{
		$this->output_json($this->ujian->HslUjianById($id, true), false);
	}

	public function index()
	{
		$data = [
			'user' => $this->user,
			'judul'	=> 'Ujian',
			'subjudul'=> 'Hasil Ujian',
		];
		$this->load->view('_templates/dashboard/_header.php', $data);
		$this->load->view('ujian/hasil');
		$this->load->view('_templates/dashboard/_footer.php');
	}
	
	public function detail($id)
	{
		$ujian = $this->ujian->getUjianById($id);
		$nilai = $this->ujian->bandingNilai($id);

		$data = [
			'user' => $this->user,
			'judul'	=> 'Ujian',
			'subjudul'=> 'Detail Hasil Ujian',
			'ujian'	=> $ujian,
			'nilai'	=> $nilai
		];

		$this->load->view('_templates/dashboard/_header.php', $data);
		$this->load->view('ujian/detail_hasil');
		$this->load->view('_templates/dashboard/_footer.php');
	}

	public function cetak($id)
	{
		$this->load->library('Pdf');

		$mhs 		= $this->ujian->getIdMahasiswa($this->user->username);
		$hasil 		= $this->ujian->HslUjian($id, $mhs->id_mahasiswa)->row();
		$ujian 		= $this->ujian->getUjianById($id);
		$benar 		= $hasil->jml_benar;
		$soal 		= $ujian->jumlah_soal;
		$datenow 	= date("Y-m-d h:i:s");
		$urlweb = base_url();

		//HASIL UJIAN
			//JAWABAN
		// $list2_jawaban = $this->ujian->getJawabanbyUjian($id,$mhs->id_mahasiswa);
		// $pecah_jawaban = explode(",", $list2_jawaban);
		// $pecah_data = explode(":", $pecah_jawaban);
		// $id_soal2 	= $pecah_data[0];
		// $jawaban	= $pecah_data[1];
			//SOAL		
		//$soal2			= $this->soal->getSoalById($id_soal2);

		// TGL MULAI
		$waktu = $ujian->tgl_mulai;
		$array1=explode("-",$waktu);
		$tahun = $array1[0];
		$bulan = $array1[1];
		$sisa1=$array1[2];
		$array2=explode(" ",$sisa1);
		$tanggal=$array2[0];
		$sisa2=$array2[1];
		$array3=explode(":",$sisa2);
		$jam=$array3[0];
		$menit=$array3[1];
		$detik=$array3[2];

		//TGL AKHIR
		$waktu2 = $ujian->terlambat;
		$array4=explode("-",$waktu2);
		$tahun2 = $array4[0];
		$bulan2 = $array4[1];
		$sisa3=$array4[2];
		$array5=explode(" ",$sisa3);
		$tanggal2=$array5[0];
		$sisa4=$array5[1];
		$array6=explode(":",$sisa4);
		$jam2=$array6[0];
		$menit2=$array6[1];
		$detik2=$array6[2];

		$data = [
			'datenow' => $datenow,
			'ujian' => $ujian,
			'hasil' => $hasil,
			'mhs'	=> $mhs,
			'thn' => $tahun,
			'bln' => $bulan,
			'tgl' => $tanggal,
			'jam' => $jam,
			'menit' => $menit,
			'thn2' => $tahun2,
			'bln2' => $bulan2,
			'tgl2' => $tanggal2,
			'jam2' => $jam2,
			'menit2' => $menit2,
			'salah' => $soal - $benar,
			'urlweb' => $urlweb,
		];
		
		$this->load->view('ujian/cetak', $data);
	}

	public function cetak_detail($id)
	{
		$this->load->library('Pdf');

		$ujian = $this->ujian->getUjianById($id);
		$nilai = $this->ujian->bandingNilai($id);
		$hasil = $this->ujian->HslUjianById($id)->result();

		$data = [
			'ujian'	=> $ujian,
			'nilai'	=> $nilai,
			'hasil'	=> $hasil
		];

		$this->load->view('ujian/cetak_detail', $data);
	}
	
}
# encoding: utf-8

require 'helper'

class TestPDFExtractor < Evacuees::Test
  include TestPDFExtractorConstants

  def setup
    @pdf_0 = Evacuees::Test.pdf_0
    @pdf_8 = Evacuees::Test.pdf_8
    @pdf_31 = Evacuees::Test.pdf_31
    @pdf_38 = Evacuees::Test.pdf_38
  end

  def test_pdf_with_index_0_has_expected_path
    test_path = File.expand_path('110803hinansya.pdf', 'test_data/pdf')
    assert_equal test_path, @pdf_0.path
  end

  def test_pdf_with_index_0_has_expected_title
    assert_equal "所在都道府県別の避難者等の数（平成２３年７月２８日現在）", @pdf_0.title
  end

  def test_pdf_with_index_0_has_expected_date
    assert_equal Date.new(2011, 7, 28), @pdf_0.date
  end

  def test_pdf_with_index_0_has_expected_header
    assert_equal pdf_0_header, @pdf_0.header
  end

  def test_pdf_with_index_0_has_expected_body
    assert_equal pdf_0_body, @pdf_0.body
  end

  def test_pdf_with_index_8_has_expected_body
    assert_equal pdf_8_body, @pdf_8.body
  end

  def test_pdf_with_index_31_has_expected_body
    assert_equal pdf_31_body, @pdf_31.body
  end

  def test_pdf_with_index_38_has_expected_header
    assert_equal pdf_38_header, @pdf_38.header
  end

  def test_pdf_with_index_38_has_expected_body
    assert_equal pdf_38_body, @pdf_38.body
  end

  def test_scanned_pdf_returns_an_error
    test_path = File.expand_path('120413hinansya.pdf', 'test_data/pdf')
    assert_raises StandardError do
      Evacuees::PDFExtractor.new(test_path).extract
    end
  end
end

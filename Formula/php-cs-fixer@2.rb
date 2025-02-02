class PhpCsFixerAT2 < Formula
  desc "Tool to automatically fix PHP coding standards issues"
  homepage "https://cs.symfony.com/"
  url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.19.3/php-cs-fixer.phar"
  sha256 "64238c2940e273f6182abe5279fea0df3707ac3d18f30909f0ab4fb6f9018f94"
  license "MIT"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, all: "d8d00d89e8a08ab5aafc11f2c7ebaa496efd73f4fe7336202a2bb4b75ad10946"
  end

  keg_only :versioned_formula
  depends_on "php"

  def install
    bin.install "php-cs-fixer.phar" => "php-cs-fixer"
  end

  test do
    (testpath/"test.php").write <<~EOS
      <?php $this->foo(   'homebrew rox'   );
    EOS
    (testpath/"correct_test.php").write <<~EOS
      <?php $this->foo('homebrew rox');
    EOS

    ENV["PHP_CS_FIXER_IGNORE_ENV"] = "1"
    system "#{bin}/php-cs-fixer", "fix", "test.php"
    assert compare_file("test.php", "correct_test.php")
  end
end

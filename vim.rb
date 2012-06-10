require 'formula'

class Vim <Formula
  url 'ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2'
  homepage 'http://www.vim.org/'
  md5 '5b9510a17074e2b37d8bb38ae09edbf2'

  def patchlevel; 548 end 
  def features; %w(tiny small normal big huge) end 

  def options
    features.map {|f| ["--#{f}", "Configure with --with-feature-#{f}"] }
  end 

  def patches
    patches = (1..patchlevel).map {|i| sprintf('ftp://ftp.vim.org/pub/vim/patches/7.3/7.3.%03d', i) }
    {:p0 => patches}
  end 

  def install
    feature = features.find {|f| ARGV.include? "--#{f}" } || "huge"
    system "./configure",
      "--disable-gui",
      "--without-x",
      "--disable-gpm",
      "--disable-nls",
      "--with-tlib=ncurses",
      "--enable-multibyte",
      "--enable-pythoninterp",
      "--enable-perlinterp",
      "--enable-rubyinterp",
      "--enable-luainterp",
      "--with-lua-prefix=/usr/local/Cellar/lua/5.1.4",
      "--enable-cscope",
      "--with-feature-#{feature}",
      "--with-features=conceal",
      "--prefix=#{prefix}" 
      "--mandir=#{man}" 
    system "make install"
  end 
end

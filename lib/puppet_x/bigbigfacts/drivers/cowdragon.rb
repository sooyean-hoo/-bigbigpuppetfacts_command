require_relative '../bbpfdrivers.rb'
# Drivers to Load the COWDRAGON method
class BBPFDrivers::COWDRAGON
  def initialise; end

  def compressmethods
    scriptname = " bash  #{File.join(File.dirname(__FILE__), '/cowdragon.sh')}"

    {
      'cowdragon::shellout2' => proc { |data, _info: {}|
                                  Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data,
                                  "( echo a | #{scriptname} > /dev/null || sudo yum install -y cowsay ) && ( cat <TMPDIR>/data.dat |  #{scriptname}  )")
                                },

      'cowdragon::shellout2::pipein::pipeout' => proc { |data, _info: {}|
                                                   Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, scriptname.to_s)
                                                 },
      'cowdragon::shellout2::filein::pipeout' => proc { |data, _info: {}|
                                                   Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, "cat <TMPDIR>/data.dat | #{scriptname}")
                                                 },
      'cowdragon::shellout2::filein::fileout' => proc { |data, _info: {}|
                                                   Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, "cat <TMPDIR>/data.dat | #{scriptname} > <TMPDIR2>/data.dat",
   '<TMPDIR2>/data.dat')
                                                 },

      'cowdragon' => proc { |data, _info: {}|
                       Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, "cat <TMPDIR>/data.dat |  #{scriptname}  ")
                     }
    }
  end

  def decompressmethods
    {
      'cowdragon::shellout2' => proc { |data, _info: {}| data },
      'cowdragon::shellout2::pipein::pipeout' => proc { |data, _info: {}| data },
      'cowdragon::shellout2::filein::pipeout' => proc { |data, _info: {}| data },
      'cowdragon::shellout2::filein::fileout' => proc { |data, _info: {}| data },
      'cowdragon' => proc { |data, _info: {}|         data }
    }
  end

  # rubocop:enable Style/ClassAndModuleChildren
  def test_methods
    decompressmethods
  end

  alias encodemethods compressmethods
  alias decodemethods decompressmethods

  def autoload_declare; end
end

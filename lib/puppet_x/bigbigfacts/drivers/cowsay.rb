require_relative '../bbpfdrivers.rb'
# Drivers to Load the Z7Z method
class BBPFDrivers::COWSAY
  def initialise; end

  def compressmethods
    {
      'cowsay::shellout2' => proc { |data, _info: {}|
                               Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data,
                               '( echo a | cowsay > /dev/null || sudo yum install -y cowsay ) && ( cat <TMPDIR>/data.dat |  cowsay  )')
                             },

      'cowsay::shellout2::pipein::pipeout' => proc { |data, _info: {}|
                                                Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, 'cowsay')
                                              },
      'cowsay::shellout2::filein::pipeout' => proc { |data, _info: {}|
                                                Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, 'cat <TMPDIR>/data.dat | cowsay')
                                              },
      'cowsay::shellout2::filein::fileout' => proc { |data, _info: {}|
                                                Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, 'cat <TMPDIR>/data.dat | cowsay > <TMPDIR2>/data.dat', '<TMPDIR2>/data.dat')
                                              },

      'cowsay' => proc { |data, _info: {}|
                    Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, 'cat <TMPDIR>/data.dat |  cowsay  ')
                  }
    }
  end

  def decompressmethods
    {
      'cowsay::shellout2' => proc { |data, _info: {}| data },
      'cowsay::shellout2::pipein::pipeout' => proc { |data, _info: {}| data },
      'cowsay::shellout2::filein::pipeout' => proc { |data, _info: {}| data },
      'cowsay::shellout2::filein::fileout' => proc { |data, _info: {}| data },
      'cowsay' => proc { |data, _info: {}|         data }
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

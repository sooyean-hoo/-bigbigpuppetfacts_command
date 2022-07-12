require_relative '../bbpfdrivers.rb'
# Drivers to Load the Z7Z method
class BBPFDrivers::COWSAY
  def initialise; end

  def compressmethods
    {
      'cowsay::shellout2' => proc { |data, _info: {}|
                               Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, 'cat <TMPDIR>/data.dat | /usr/local/bin/cowsay  ' )
                             },
      'cowsay' => proc { |data, _info: {}|
        Facter::Util::Bigbigpuppetfacts.compressmethods['cowsay::shellout2'].call(data,_info)
      }
    }
  end

  def decompressmethods
    {
    'cowsay::shellout2' => proc { |data, _info: {}|
                             Facter::Util::Bigbigpuppetfacts.compressmethods['::shellout2'].call(data, 'cat <TMPDIR>/data.dat | /usr/local/bin/cowsay  ' )
                           },
    'cowsay' => proc { |data, _info: {}|
      Facter::Util::Bigbigpuppetfacts.compressmethods['cowsay::shellout2'].call(data,_info)
    }
    }
  end

  # rubocop:enable Style/ClassAndModuleChildren
  def test_methods
    {

      'cowsay::shellout2' => proc { |data, _info: {}|
                              data
                             },
      'cowsay' => proc { |data, _info: {}|
        data
      }


    }
  end

  alias encodemethods compressmethods
  alias decodemethods decompressmethods

  def autoload_declare
  end
end

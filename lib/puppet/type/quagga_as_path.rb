Puppet::Type.newtype(:quagga_as_path) do
  @doc = %q{
    This type provides the capabilities to manage as-path access-list within puppet.

      Examples:

        quagga_as_path { 'as100':
            ensure => present,
            rules => [
                { permit => '_100$', },
                { permit => '_100_', },
            ],
        }
  }

  ensurable

  newparam(:name) do
    desc %q{ The name of the as-path access-list. }

    newvalues(/\A\w+\Z/)
  end

  newproperty(:rules, :array_matching => :all) do
    desc %q{ Rules of the as-path access-list. `action regex`. }

    newvalues(/\A(permit|deny)\s\^?[_\d\.\\\*\+\[\]\|\?]+\$?\Z/)

    def should_to_s(newvalue = @should)
      if newvalue
        newvalue.inspect
      else
        nil
      end
    end
  end

  autorequire(:package) do
    case value(:provider)
      when :quagga
        %w{quagga}
      else
        []
    end
  end

  autorequire(:service) do
    case value(:provider)
      when :quagga
        %w{zebra ospfd}
      else
        []
    end
  end
end
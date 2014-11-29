package Mojolicious::Plugin::GeoCoder;

use strict;
use warnings FATAL => 'all';
use Mojo::Base 'Mojolicious::Plugin';
use Geo::Coder::Google;
use Data::Dumper;
=head1 GeoCoder

Mojolicious::Plugin::GeoCoder - The great new Mojolicious::Plugin::GeoCoder!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Mojolicious::Plugin::GeoCoder;

    my $foo = Mojolicious::Plugin::GeoCoder->new();
    ...
=cut

sub register {
    my ($self,$app,$rh_conf) = @_;
    $app->helper(geocode => sub {
        my ($self,$rh_args) = @_;
        
        return { } unless($rh_args->{location});

        my $geocoder = Geo::Coder::Google->new(
                apiver      => 3,
                ( $rh_args->{country_code} || $rh_conf->{country_code} ?
                    (gl          => $rh_args->{country_code} || $rh_conf->{country_code}) : ()),
                language    => $rh_args->{language_code} || $rh_conf->{language_code}  || 'en',
                );

        my $rh_response = $geocoder->geocode(location=> $rh_args->{location});

        return $rh_response if($rh_conf->{raw_response} || $rh_conf->{raw_response});

        return {
                address => $rh_response->{formatted_address},
                lat     => $rh_response->{geometry}{location}{lat},
                lng     => $rh_response->{geometry}{location}{lng},
            };
    });
}


=head1 AUTHOR

Rohit Deshmukh, C<< <raigad1630 at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-mojolicious-plugin-geocoder at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Mojolicious-Plugin-GeoCoder>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Mojolicious::Plugin::GeoCoder


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Mojolicious-Plugin-GeoCoder>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Mojolicious-Plugin-GeoCoder>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Mojolicious-Plugin-GeoCoder>

=item * Search CPAN

L<http://search.cpan.org/dist/Mojolicious-Plugin-GeoCoder/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2014 Rohit Deshmukh.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Mojolicious::Plugin::GeoCoder

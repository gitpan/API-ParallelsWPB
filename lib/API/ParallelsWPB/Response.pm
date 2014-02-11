package API::ParallelsWPB::Response;
use strict;
use warnings;
use JSON;

# ABSTRACT: processing of API responses

our $VERSION = '0.01'; # VERSION
our $AUTHORITY = 'cpan:IMAGO'; # AUTHORITY


sub new {
    my ( $class, $res ) = @_;

    my $success    = $res->is_success;
    my $json       = $success ? $res->content : '';
    my $error_json = $success ? '' : $res->content;
    my $status     = $res->status_line;

    my $parsed_response = $json       ? JSON::decode_json( $json )       : {};
    my $parsed_error    = $error_json ? eval { JSON::decode_json( $error_json )} : {};

    return bless(
        {
            success  => $success,
            json     => $json,
            error    => $parsed_error->{error}->{message},
            response => $parsed_response->{response},
            status   => $status
        },
        $class
    );
}



sub json {
    my $self = shift;

    return $self->{json};
}


sub success {
    my $self = shift;

    return $self->{success};
}


sub response {
    my $self = shift;

    return $self->{response};
}


sub status {
    my $self = shift;

    return $self->{status};
}



sub error {
    my $self = shift;

    return $self->{error};
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

API::ParallelsWPB::Response - processing of API responses

=head1 VERSION

version 0.01

=head1 METHODS

=head2 B<new($class, $res)>

Creates new API::ParallelsWPB::Response object.

$res - HTTP::Response object.

=head2 B<json($self)>

Returns original JSON answer.

=head2 B<success($self)>

Returns 1 if request succeeded, 0 otherwise.

=head2 B<response($self)>

Returns munged response from service. According to method, it can be scalar, hashref of arrayref.

=head2 B<status($self)>

Returns response status line.

=head2 B<error($self)>

Returns munged error text.

=head1 SEE ALSO

L<Parallels Presence Builder Guide|http://download1.parallels.com/WPB/Doc/11.5/en-US/online/presence-builder-standalone-installation-administration-guide>

L<API::ParallelsWPB>

L<API::ParallelsWPB::Requests>

=cut

=head1 AUTHORS

=over 4

=item *

Alexander Ruzhnikov <a.ruzhnikov@reg.ru>

=item *

Polina Shubina <shubina@reg.ru>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by REG.RU LLC.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
